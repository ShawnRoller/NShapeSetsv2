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
    @State private var selectedSets: Int = 15
    @State private var selectedRest: Int = 90
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
            .padding()
            NavigationLink(destination: ActiveWorkoutView(selectedWorkout: workoutType,workout: Workout(rounds: selectedSets, rest: selectedRest))) {
                Text("Start")
                    .foregroundColor(Palette.primaryButtonTitleText)
                    .watchCtaFont()
            }
            .frame(height: 36)
            .background(Palette.primaryButtonFill)
            .cornerRadius(100)
            .padding(.horizontal)
        }
        .navigationTitle {
            Text(workoutType.name)
                .font(.title3)
                .foregroundStyle(Palette.secondary)
        }
        .padding(.bottom)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    SetupView()
}
