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
    let selectedWorkout: WorkoutType
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .done
    @State private var showingRecap = false
    
    @ObservedObject var workout: Workout
    @Environment(WorkoutManager.self) private var hkHelper
    private var healthStore = HKHealthStore()
    
    private var buttonTitle: String {
        var title = "Start"
        switch workout.state {
        case .Setup:
            title = "Start"
        case .Active:
            title = workout.currentSet == workout.rounds ? "Done" : "Rest"
        case .Rest:
            title = "Skip"
        case .Recap:
            title = "Setup"
        default:
            break
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
    
    init(selectedWorkout: WorkoutType, workout: Workout) {
        self.selectedWorkout = selectedWorkout
        self.workout = workout
    }
    
    var body: some View {
        VStack {
            InfoBar(progress: workout.progress, totalSeconds: workout.totalTimer.totalTime, detailColor: .secondary, detailOnTop: true, currentSet: workout.currentSet, totalSets: workout.rounds)
                .padding([.top], 35.0)
                .padding([.leading, .trailing])
            Spacer()
            getView(for: workout)
            PrimaryButton(title: buttonTitle, buttonColor: buttonColor) {
                self.onCTAPress()
            }
        }
        .onChange(of: workout.state) { prev, new in
            if new == WorkoutState.Done {
                self.goBack()
            }
        }
        .onChange(of: workout.timer.remainingTime) { prev, new in
            self.countdown()
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
                        self.endWorkout()
                        self.showingRecap = true
                    }
                }))
            } else {
                return Alert(title: Text("All done?"), primaryButton: .destructive(Text("Done!"), action: {
                    self.endWorkout()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                        self.endWorkout()
                        self.showingRecap = true
                    }
                }), secondaryButton: .cancel())
            }
        }
        .padding(.bottom, 0)
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
        .sheet(isPresented: $showingRecap, onDismiss: {
            workout.state = .Done
        }) {
            RecapView(workout: workout, workoutType: selectedWorkout)
        }
    }
    
    func onCTAPress() -> Void {
        switch workout.state {
        case .Setup:
            workout.startWorkout()
        case .Active:
            workout.startRest()
            if workout.currentSet == workout.rounds {
                endWorkout()
                showingRecap = true
            }
        case .Rest:
            workout.skipRest()
        case .Recap:
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.goBack()
            }
        default: break
        }
    }
    
    func setDefaultSettings() {
        let defaultWorkoutRest = self.workout.rest
        let defaultWorkoutSets = self.workout.rounds
        
        DefaultManager.setDefault(value: defaultWorkoutRest, forKey: Defaults.workoutRest)
        DefaultManager.setDefault(value: defaultWorkoutSets, forKey: Defaults.workoutRounds)
    }
    
    func startWorkout() {
        hkHelper.startWorkout(workoutType: selectedWorkout.type)
        workout.startWorkout()
    }
    
    func endWorkout() {
        hkHelper.endWorkout()
        workout.endWorkout()
    }
    
    func getView(for workout: Workout) -> some View {
        WorkoutView(workout: workout)
    }
    
    func countdown() {
        if 1...3 ~= workout.timer.remainingTime {
            HapticHelper.playCountdownHaptic()
        } else if workout.timer.remainingTime == 0 {
            HapticHelper.playStartHaptic()
        }
    }
    
    func goBack() {
        os_log("Going back to setup...", log: .ui)
        workout.endWorkout()
        workout.reset()
        presentationMode.wrappedValue.dismiss()
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkoutView(selectedWorkout: workouts.first!, workout: Workout.example)
    }
}
