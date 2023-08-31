//
//  ActiveWorkoutView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import SwiftUI
import HealthKit
import os

struct ActiveWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .done
    @State private var isRecap = true
    
    @ObservedObject var workout: Workout
    private var healthStore = HKHealthStore()
    
    private var buttonTitle: String {
        var title: String
        switch workout.state {
        case .Setup:
            title = "Start"
        case .Active:
            title = workout.currentSet == workout.rounds ? "Done" : "Rest"
        case .Rest:
            title = "Skip"
        case .Recap:
            title = "Let's go"
        }
        return title
    }
    
    private var buttonColor: Color {
        var color = Palette.secondary
        switch workout.state {
        case .Rest:
            color = Palette.tertiary
        default:
            color = Palette.secondary
        }
        return color
    }
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var body: some View {
        VStack {
            InfoBar(progress: workout.progress, totalSeconds: workout.totalTimer.totalTime, detailColor: .secondary, detailOnTop: true)
                .padding([.top], 22.0)
                .padding([.leading, .trailing])
            Spacer()
            getView(for: workout)
            Spacer()
            Group {
                if workout.currentSet == workout.rounds {
                    NavigationLink(destination: RecapView()) {
                        Text("Done")
                            .foregroundColor(Palette.primaryButtonTitleText)
                            .watchCtaFont()
                    }
                    .frame(height: 44)
                    .background(Palette.primaryButtonFill)
                    .cornerRadius(100)
                } else {
                    PrimaryButton(title: buttonTitle, buttonColor: buttonColor) {
                        self.onCTAPress()
                    }
                }
            }
        }
        .onAppear() {
            os_log("Active workout appeared!", log: .ui)
            self.setDefaultSettings()
            self.startWorkout()
        }
        .alert(isPresented: $showingAlert) {
            if (activeAlert == .done) {
                self.endWorkout()
                return Alert(title: Text("Workout complete!"), message: Text("You completed all sets in \(workout.totalTimer.totalTime)!"), dismissButton: .default(Text("OK"), action: {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                        self.goBack()
                    }
                }))
            } else {
                return Alert(title: Text("All done?"), primaryButton: .destructive(Text("Done!"), action: {
                        self.endWorkout()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                            self.goBack()
                        }
                }), secondaryButton: .cancel())
            }
        }
        .ignoresSafeArea(edges: [.bottom, .top])
        .onDisappear() {
            if !self.showingAlert {
                self.endWorkout()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(id: "back", placement: .cancellationAction, showsByDefault: false) {
                Button(action: {
                    self.activeAlert = .back
                    self.showingAlert = true
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                })
            }
        })
    }
    
    func onCTAPress() -> Void {
        switch workout.state {
        case .Setup:
            workout.startWorkout()
        case .Active:
            if workout.currentSet == workout.rounds {
                self.endWorkout()
            } else {
                workout.startRest()
            }
        case .Rest:
            workout.nextSet()
        case .Recap:
            self.endWorkout()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.goBack()
            }
        }
    }
    
    func setDefaultSettings() {
        let defaultWorkoutRest = self.workout.rest
        let defaultWorkoutSets = self.workout.rounds
        
        DefaultManager.setDefault(value: defaultWorkoutRest, forKey: Defaults.workoutRest)
        DefaultManager.setDefault(value: defaultWorkoutSets, forKey: Defaults.workoutRounds)
    }
    
    func startWorkout() {
        workout.startWorkout()
    }
    
    func endWorkout() {
        print("ending workout")
        workout.endWorkout()
        isRecap = true
    }
    
    func getView(for workout: Workout) -> some View {
        WorkoutView(workout: workout)
    }
    
    func countdown() {
        if 1...3 ~= workout.timer.remainingTime {
            HapticHelper.playCountdownHaptic()
        }
    }
    
    func onRestEnd() {
        os_log("rest is over", log: .ui)
        HapticHelper.playStartHaptic()
        workout.nextSet()
    }
    
    func goBack() {
        os_log("Going back to setup...", log: .ui)
        workout.reset()
        presentationMode.wrappedValue.dismiss()
    }
    
    func onRest() {
        os_log("Rest started", log: .ui)
        if workout.currentSet == workout.rounds {
            activeAlert = .done
            showingAlert = true
        }
        else {
            workout.startRest()
        }
    }
    
    func onSkip() {
        os_log("Rest was skipped", log: .ui)
        onRestEnd()
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkoutView(workout: Workout.example)
    }
}
