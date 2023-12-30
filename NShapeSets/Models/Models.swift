//
//  Test.swift
//  NShapeSets
//
//  Created by Shawn Roller on 11/26/23.
//

import Foundation
import HealthKit

enum WorkoutState: String, Codable {
    case Setup
    case Active
    case Rest
    case Recap
    case Done
}

struct WorkoutType: Identifiable {
    let id = UUID()
    let name: String
    let type: HKWorkoutActivityType
}

let workouts: [WorkoutType] = [WorkoutType(name: "Strength", type: .traditionalStrengthTraining), WorkoutType(name: "HIIT", type: .highIntensityIntervalTraining)]

