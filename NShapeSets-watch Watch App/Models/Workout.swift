//
//  Workout.swift
//  NShapeSets
//
//  Created by Shawn Roller on 6/18/23.
//

import Foundation
import HealthKit
import WorkoutKit

struct Training {
    let warmup: Double
    let cooldown: Double
    let rounds: Int
    let rest: Double
    let workoutType: HKWorkoutActivityType
    
    static let example = Training(warmup: 10, cooldown: 30, rounds: 6, rest: 66, workoutType: .traditionalStrengthTraining)
}

func generateWarmupStep(time: Double) -> WorkoutStep {
//    let seconds = HKQuantity(unit: .second(), doubleValue: time)
    let goal: WorkoutGoal = .time(time, .seconds)
    let step = WorkoutStep(goal: goal)
    
    return step
}

func generateCooldownStep(time: Double) -> WorkoutStep {
    let goal: WorkoutGoal = .time(time, .seconds)
    let step = WorkoutStep(goal: goal)
    
    return step
}

func generateRestStep(time: Double) -> IntervalStep {
    var restStep = IntervalStep(.recovery)
    restStep.step.goal = .time(time, .seconds)
    
    return restStep
}

func generateWorkStep() -> IntervalStep {
    var workStep = IntervalStep(.work)
    workStep.step.goal = .open
    
    return workStep
}

func generateBlock(rounds: Int, time: Double) -> IntervalBlock {
    let workStep = generateWorkStep()
    let restStep = generateRestStep(time: time)
    
    let block = IntervalBlock(steps: [workStep, restStep], iterations: rounds)
    
    return block
}

func generateComposition(from training: Training) -> CustomWorkout {
    let warmupStep = generateWarmupStep(time: training.warmup)
    let cooldownStep = generateCooldownStep(time: training.cooldown)
    let block = generateBlock(rounds: training.rounds, time: training.rest)
    
    let activity: HKWorkoutActivityType = training.workoutType
    
    let customComposition = CustomWorkout(activity: activity, displayName: "NShape Sets", warmup: warmupStep, blocks: [block], cooldown: cooldownStep)
    
    return customComposition
}

struct WorkoutType: Identifiable {
    let id = UUID()
    let name: String
    let type: HKWorkoutActivityType
}

let workouts: [WorkoutType] = [WorkoutType(name: "Strength", type: .traditionalStrengthTraining), WorkoutType(name: "HIIT", type: .highIntensityIntervalTraining)]
