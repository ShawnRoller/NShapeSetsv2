//
//  Workout.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/6/23.
//

import Foundation

enum WorkoutState {
    case Setup
    case Active
    case Rest
    case Recap
}

struct Workout {
    var rounds: Int
    var rest: Int
    var superSets: Int
    var state: WorkoutState
    var currentSet: Int
    var restRemaining: Int
    
    init(rounds: Int, rest: Int, superSets: Int = 1) {
        self.rounds = rounds
        self.rest = rest
        self.superSets = superSets
        self.state = .Setup
        self.currentSet = 1
        self.restRemaining = rest
    }
    
    static var example = Workout(rounds: 16, rest: 90)
}


