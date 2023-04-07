//
//  Workout.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/6/23.
//

import SwiftUI
import Combine

enum WorkoutState {
    case Setup
    case Active
    case Rest
    case Recap
}

class Workout: ObservableObject {
    @Published var rounds: Int
    @Published var rest: Int {
        didSet {
            restRemaining = rest
        }
    }
    @Published var superSets: Int
    @Published var state: WorkoutState
    @Published var currentSet: Int
    @Published var restRemaining: Int
    var progress: Float {
        Float(currentSet) / Float(rounds) * 100
    }
    
    private var progressCancellable: AnyCancellable?
    
    func startWorkout() -> Void {
        state = .Active
    }
    
    func startRest() -> Void {
        if currentSet == rounds {
            endWorkout()
        } else {
            state = .Rest
        }
    }
    
    func nextSet() -> Void {
        state = .Active
        currentSet += 1
    }
    
    func endWorkout() -> Void {
        state = .Recap
    }
    
    func reset() -> Void {
        state = .Setup
    }
    
    init(rounds: Int, rest: Int, superSets: Int = 1) {
        self.rounds = rounds
        self.rest = rest
        self.superSets = superSets
        self.state = .Setup
        self.currentSet = 1
        self.restRemaining = rest
        
        progressCancellable = $currentSet.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    static var example = Workout(rounds: 16, rest: 90)
}


