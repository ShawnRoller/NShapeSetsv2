//
//  SetupView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 6/18/23.
//

import SwiftUI
import WorkoutKit

struct SetupView: View {
    private let sets: [Int] = Array(1...99)
    private let restValues: [Int] = Array(5...300)
    private var rest: [Int] {
        return restValues.compactMap { v in v % 5 == 0 ? v : nil }
    }
    @State private var selectedSets: Double = 15
    @State private var selectedRest: Double = 90
    var workoutType: WorkoutType = workouts.first!
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Sets")
                        .font(.footnote)
                        .bold()
                    Picker("Sets", selection: $selectedSets) {
                        ForEach(sets, id: \.self) {
                            Text(String($0))
                                .font(.title2)
                        }
                    }
                    .labelsHidden()
                }
                VStack {
                    Text("Rest")
                        .font(.footnote)
                        .bold()
                    Picker("Rest", selection: $selectedRest) {
                        ForEach(rest, id: \.self) {
                            Text(String($0))
                                .font(.title2)
                        }
                    }
                    .labelsHidden()
                }
            }
            Button("Create workout") {
                let training = Training(warmup: 10, cooldown: 30, rounds: Int(selectedSets), rest: selectedRest, workoutType: workoutType.type)
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
            .padding()
            .buttonStyle(BorderedButtonStyle(tint: Palette.primaryButtonFill))
        }
        .navigationTitle {
            Text(workoutType.name)
                .font(.title3)
                .foregroundStyle(Palette.secondary)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    SetupView()
}
