//
//  Workout.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/6/23.
//

import Combine
import SwiftUI

class Workout: ObservableObject, Identifiable {
    @ObservedObject private var notifications = Notifications.shared
    @ObservedObject var timer: CountdownTimer
    @ObservedObject var totalTimer = TotalTimer()
    @Published var rounds: Int
    @Published var rest: Int {
        didSet {
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
    var progress: Float {
        Float(currentSet) / Float(rounds) * 100
    }
    
    private var progressCancellable: AnyCancellable?
    private var timerCancellable: AnyCancellable?
    private var totalCancellable: AnyCancellable?
    
    func startWorkout() -> Void {
        state = .Active
        timer.stop()
        totalTimer.start()
        
        totalCancellable = totalTimer.$totalTime.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func startRest() -> Void {
        if currentSet == rounds {
            endWorkout()
        } else {
            state = .Rest
            setupTimer()
            timer.start()
            notifications.scheduleRestNotification(currentSet: currentSet, totalSets: rounds, restSeconds: rest)
        }
    }
    
    func nextSet() -> Void {
        state = .Active
        currentSet += 1
        timer.stop()
        notifications.cancelNotifications()
    }
    
    func endWorkout() -> Void {
        state = .Recap
        timer.stop()
        totalTimer.pause()
        notifications.cancelNotifications()
    }
    
    func reset() -> Void {
        endWorkout()
        
        totalTimer.stop()
        state = .Setup
        currentSet = 1
        notifications.cancelNotifications()
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
        timer = CountdownTimer(initialTime: rest, onCountdownComplete: {})
        
        // update progress when the currentSet changes
        progressCancellable = $currentSet.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    static var example = Workout(rounds: 3, rest: 6)
}
