//
//  WorkoutView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 8/17/23.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workout: Workout
    private var progress: CGFloat {
        CGFloat(workout.timer.remainingTime) / CGFloat(workout.rest)
    }
    
    var body: some View {
        ZStack {
            CircleGradient()
                .padding()
            ProgressRing(progress: progress, isRest: workout.state == .Rest, ringWidth: 5)
            renderText(for: workout)
        }
        .frame(maxHeight: .infinity)
    }
    
    func renderText(for workout: Workout) -> some View {
        return Group {
            if workout.state == .Rest {
                RestTimeView(remainingTime: workout.timer.remainingTime)
            } else {
                SetsView(currentSet: workout.currentSet, totalSets: workout.rounds)
            }
        }
    }
}

#Preview {
    WorkoutView(workout: Workout.example)
}
