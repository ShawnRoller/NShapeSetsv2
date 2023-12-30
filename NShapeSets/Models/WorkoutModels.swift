//
//  Workout.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/6/23.
//

import Combine
import HealthKit
import os
import SwiftUI

class Workout: ObservableObject, Identifiable {
    @ObservedObject private var healthManager = HealthManager.shared
    @ObservedObject private var notifications = Notifications.shared
    @ObservedObject var timer: CountdownTimer
    @ObservedObject var totalTimer = TotalTimer()
    @Published var rounds: Int {
        didSet {
            // save default
            self.saveDefaults()
        }
    }
    @Published var rest: Int {
        didSet {
            // save default
            self.saveDefaults()
            
            // set the remaining rest if the rest value is changing during a workout
            self.timer = CountdownTimer(initialTime: rest, onCountdownComplete: nextSet)
            //update remainingRest when the timer changes
            timerCancellable = timer.$remainingTime.sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            if state == .Rest {
                self.timer.start()
            }
        }
    }
    @Published var superSets: Int
    @Published var state: WorkoutState
    @Published var currentSet: Int
    @Published var completedSets: Int
    @Published var skippedRest: Int
    @Published var totalRestTime: Int
    
    var progress: Float {
        Float(currentSet) / Float(rounds) * 100
    }
    
    private var progressCancellable: AnyCancellable?
    private var timerCancellable: AnyCancellable?
    private var totalCancellable: AnyCancellable?
    
    // Track how long we've been resting
    private var startRestDate: Date?
    
    func saveDefaults() -> Void {
        let defaultWorkoutRest = rest
        let defaultWorkoutSets = rounds
        
        DefaultManager.setDefault(value: defaultWorkoutRest, forKey: Defaults.workoutRest)
        DefaultManager.setDefault(value: defaultWorkoutSets, forKey: Defaults.workoutRounds)
    }
    
    func startWorkout() -> Void {
        state = .Active
        timer.stop()
        totalTimer.start()
        
        totalCancellable = totalTimer.$totalTime.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func startRest() -> Void {
        completedSets += 1
        if currentSet == rounds {
            endWorkout()
        } else {
            startRestDate = .now
            state = .Rest
            setupTimer()
            timer.start()
            notifications.scheduleRestNotification(currentSet: currentSet, totalSets: rounds, restSeconds: rest)
        }
    }
    
    func skipRest() -> Void {
        skippedRest += 1
        nextSet()
    }
    
    func nextSet() -> Void {
        state = .Active
        currentSet += 1
        timer.stop()
        notifications.cancelNotifications()
        endRestTracking()
    }
    
    func endWorkout() -> Void {
        state = .Recap
        timer.stop()
        totalTimer.pause()
        notifications.cancelNotifications()
        endRestTracking()
        
        // Save the workout to healthkit
        let seconds = totalTimer.totalTime
        let userCalendar = Calendar.current
        let date = Date()
        var durationComponents = DateComponents()
        durationComponents.second = seconds * -1
        guard let startDate = (userCalendar as NSCalendar).date(byAdding: durationComponents, to: date, options: []) else {
            os_log("Could not get startDate to save workout", log: .healthKit)
            return
        }
        
        // Estimate the calories burned
        let calories = healthManager.getCalories(for: HKWorkoutActivityType.highIntensityIntervalTraining, seconds: totalTimer.totalTime)
        healthManager.saveWorkout(calories, startDate: startDate, endDate: date)
    }
    
    func reset() -> Void {
        endWorkout()
        
        totalTimer.stop()
        state = .Setup
        currentSet = 1
        notifications.cancelNotifications()
    }
    
    private func endRestTracking() -> Void {
        guard let startRestDate else { return }
        let currentDate = Date.now
        let differenceInSeconds = currentDate - startRestDate
        totalRestTime += Int(differenceInSeconds)
        self.startRestDate = nil
    }
    
    func setupTimer() -> Void {
        timer = CountdownTimer(initialTime: self.rest, onCountdownComplete: nextSet)
        
        //update remainingRest when the timer changes
        timerCancellable = timer.$remainingTime.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    init(rounds: Int, rest: Int, superSets: Int = 1) {
        self.rounds = rounds
        self.rest = rest
        self.superSets = superSets
        self.state = .Setup
        self.currentSet = 1
        self.completedSets = 0
        self.skippedRest = 0
        self.totalRestTime = 0
        timer = CountdownTimer(initialTime: rest, onCountdownComplete: {})
        
        // update progress when the currentSet changes
        progressCancellable = $currentSet.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    static var example = Workout(rounds: 12, rest: 60)
}
