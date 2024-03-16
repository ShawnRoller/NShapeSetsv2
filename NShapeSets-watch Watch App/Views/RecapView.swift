//
//  RecapView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 8/1/23.
//

import SwiftUI

struct RecapView: View {
    var workout: Workout
    var workoutType: WorkoutType
    @Environment(\.dismiss) var dismiss
    
    private var time: String {
        return getTime(from: workout.totalTimer.totalTime)
    }
    private var activeTime: String {
        return getTime(from: workout.totalTimer.totalTime - workout.totalRestTime)
    }
    
    var body: some View {
        List {
            Section {
                Text("Recap")
                    .watchCtaFont()
                    .foregroundColor(Palette.primary)
                    .listRowBackground(Color.white.opacity(0))
                Text(workoutType.name)
                    .foregroundColor(Palette.secondary)
                    .listRowBackground(Color.white.opacity(0))
            }
            .frame(height: 10)
            
            RecapDetailView(title: "Sets", value: "\(workout.completedSets)")
            RecapDetailView(title: "Skipped rest", value: "\(workout.skippedRest)")
            RecapDetailView(title: "Heartrate", value: "\(WorkoutManager().averageHeartRate)")
            RecapDetailView(title: "Total time", value: time)
            RecapDetailView(title: "Active time", value: activeTime)
        }
    }
}

#Preview {
    RecapView(workout: Workout.example, workoutType: workouts.first!)
}
