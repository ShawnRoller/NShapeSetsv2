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
    @State private var workoutState: ScreenState = .active
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .done
    @ObservedObject var timer: TimerWrapper
    
    var workout: Workout
    
    private var healthStore = HKHealthStore()
    
    init(workout: Workout) {
        self.workout = workout
        self.timer = TimerWrapper.example
    }
    
    func startWorkout() {
    }
    
    func endWorkout() {
        self.timer.stopTimeTracking()
    }
    
    var body: some View {
        VStack {
            getViewForState(workoutState)
        }
        .onAppear() {
            os_log("Active workout appeared!", log: .ui)
            self.setDefaultSettings()
            self.timer.startTimeTracking()
            self.startWorkout()
        }
        .alert(isPresented: $showingAlert) {
            if (activeAlert == .done) {
                self.endWorkout()
                let totalTime = TimeHelper.getTimeFromSeconds(self.timer.totalTime)
                return Alert(title: Text("Workout complete!"), message: Text("You completed all sets in \(totalTime)!"), dismissButton: .default(Text("OK"), action: {
                    self.timer.reset()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                        self.goBack()
                    }
                }))
            } else {
                return Alert(title: Text("All done?"), primaryButton: .destructive(Text("Done!"), action: {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                            self.goBack()
                        }
                }), secondaryButton: .cancel())
            }
        }
        .onDisappear() {
            if !self.showingAlert {
                self.endWorkout()
                self.timer.reset()
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
    
    func setDefaultSettings() {
        let defaultWorkoutRest = self.workout.rest
        let defaultWorkoutSets = self.workout.rounds
        
        DefaultManager.setDefault(value: defaultWorkoutRest, forKey: Defaults.workoutRest)
        DefaultManager.setDefault(value: defaultWorkoutSets, forKey: Defaults.workoutRounds)
    }
    
    func getViewForState(_ state: ScreenState) -> some View {
        return Group {
            if timer.isActive {
                RestView(workout: workout, timer: timer) {
                    self.onSkip()
                }
            }
            else {
                ActiveView(workout: workout, timer: timer) {
                    self.onRest()
                }
            }
        }
    }
    
    func countdown() {
        if 1...3 ~= timer.remainingRest {
            HapticHelper.playCountdownHaptic()
        }
    }
    
    func onRestEnd() {
        os_log("rest is over", log: .ui)
        HapticHelper.playStartHaptic()
        workoutState = workoutState == .active ? .rest : .active
        timer.restComplete()
    }
    
    func goBack() {
        os_log("Going back to setup...", log: .ui)
        presentationMode.wrappedValue.dismiss()
    }
    
    func onRest() {
        os_log("Rest started", log: .ui)
        if timer.currentRound == timer.rounds {
            activeAlert = .done
            showingAlert = true
        }
        else {
            workoutState = workoutState == .active ? .rest : .active
            timer.start()
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
