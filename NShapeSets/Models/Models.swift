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

private let workoutTypes = [
    WorkoutType(name: "Strength", type: .traditionalStrengthTraining),
    WorkoutType(name: "HIIT", type: .highIntensityIntervalTraining),
    WorkoutType(name: "Core", type: .coreTraining),
    WorkoutType(name: "Crossfit", type: .crossTraining),
    WorkoutType(name: "Stretching", type: .flexibility),
    WorkoutType(name: "Sprint", type: .running),
    WorkoutType(name: "Other", type: .other)
]

let workouts: [WorkoutType] = [WorkoutType(name: "Strength", type: .traditionalStrengthTraining), WorkoutType(name: "HIIT", type: .highIntensityIntervalTraining)]

