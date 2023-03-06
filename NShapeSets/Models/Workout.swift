//
//  Workout.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/6/23.
//

import Foundation

struct Workout {
    var rounds: Int
    var rest: Int
    var superSets: Int = 1
    
    static var example = Workout(rounds: 16, rest: 90)
}
