//
//  SetupView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 6/18/23.
//

import SwiftUI
import WorkoutKit

struct SettingsView: View {
    let sets: [Int]
    let restValues: [Int] = Array(5...300)
    private var rest: [Int] {
        return restValues.compactMap { v in v % 5 == 0 ? v : nil }
    }
    @Binding var selectedSets: Int
    @Binding var selectedRest: Int
    
    var body: some View {
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
    }
}

struct SetupView: View {
    @State private var selectedSets: Int = 15
    @State private var selectedRest: Int = 90
    var workoutType: WorkoutType = workouts.first!
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                SettingsView(sets: Array(1...99), selectedSets: $selectedSets, selectedRest: $selectedRest)
                .frame(maxHeight: proxy.size.height / 1.3)
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
        .onAppear {
            loadDefaults()
        }
    }
    
    func loadDefaults() -> Void {
        let rest = DefaultManager.getDefault(forKey: Defaults.workoutRest) as? Int ?? Workout.example.rest
        let rounds = DefaultManager.getDefault(forKey: Defaults.workoutRounds) as? Int ?? Workout.example.rounds
        
        selectedRest = rest
        selectedSets = rounds
    }
}

#Preview {
    SetupView()
}
