//
//  ContentView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 6/8/23.
//

import SwiftUI
import HealthKit
import WorkoutKit

struct Training {
    let warmup: Double
    let cooldown: Double
    let rounds: Int
    let rest: Double
    
    static let example = Training(warmup: 10, cooldown: 30, rounds: 6, rest: 66)
}

func generateWarmupStep(time: Double) -> WarmupStep {
    let seconds = HKQuantity(unit: .second(), doubleValue: time)
    let goal: WorkoutGoal = .time(seconds)
    let step = WarmupStep(goal: goal)
    
    return step
}

func generateCooldownStep(time: Double) -> CooldownStep {
    let seconds = HKQuantity(unit: .second(), doubleValue: time)
    let goal: WorkoutGoal = .time(seconds)
    let step = CooldownStep(goal: goal)
    
    return step
}

func generateRestStep(time: Double) -> BlockStep {
    let seconds = HKQuantity(unit: .second(), doubleValue: time)
    let goal: WorkoutGoal = .time(seconds)
    let step = BlockStep(.rest, goal: goal)
    
    return step
}

func generateWorkStep() -> BlockStep {
    // create an open goal
    let step = BlockStep(.work)
    
    return step
}

func generateBlock(rounds: Int, time: Double) -> IntervalBlock {
    let workStep = generateWorkStep()
    let restStep = generateRestStep(time: time)
    
    let block = IntervalBlock(steps: [workStep, restStep], iterations: rounds)
    
    return block
}

func generateComposition(from training: Training) -> CustomWorkoutComposition {
    let warmupStep = generateWarmupStep(time: training.warmup)
    let cooldownStep = generateCooldownStep(time: training.cooldown)
    let block = generateBlock(rounds: training.rounds, time: training.rest)
    
    let activity: HKWorkoutActivityType = .highIntensityIntervalTraining
    
    guard let customComposition = try? CustomWorkoutComposition(activity: activity, displayName: "NShape Sets", warmup: warmupStep, blocks: [block], cooldown: cooldownStep) else {
        fatalError("sumting wong")
    }
    
    return customComposition
}

struct ContentView: View {
    private let sets: [Int] = Array(1...99)
    private let restValues: [Int] = Array(5...300)
    private var rest: [Int] {
        return restValues.compactMap { v in v % 5 == 0 ? v : nil }
    }
    @State private var selectedSets: Double = 15
    @State private var selectedRest: Double = 90
    
    
    var body: some View {
        VStack {
            HStack {
                Picker("Sets", selection: $selectedSets) {
                    ForEach(sets, id: \.self) {
                        Text(String($0))
                            .font(.title2)
                    }
                }
                Picker("Rest", selection: $selectedRest) {
                    ForEach(rest, id: \.self) {
                        Text(String($0))
                            .font(.title2)
                    }
                }
            }
            Button("Generate workout") {
                let training = Training(warmup: 10, cooldown: 30, rounds: Int(selectedSets), rest: selectedRest)
                let composition = generateComposition(from: training)
                let workoutComposition = WorkoutComposition(customComposition: composition)
                print(workoutComposition)
                Task {
                    do {
                        try await workoutComposition.presentPreview()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}