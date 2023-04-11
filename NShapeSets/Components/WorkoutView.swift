//
//  WorkoutView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//
//  This displays the "active" content (active ring, current set, sets remaining)
//  or the "rest" content (rest ring, rest time remaining)
//
//  It accepts the workout (# of sets, rest per set), currentSet, isRest, and rest remaining

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workout: Workout
    private var progress: CGFloat {
        CGFloat(workout.restRemaining) / CGFloat(workout.rest)
    }
    private var setsRemainingString: String {
        let remaining = workout.rounds - workout.currentSet
        
        return remaining == 0 ? "final set" :
               remaining == 1 ? "1 set left" :
               "\(remaining) sets left"
    }
    private var titleText: String {
        workout.state == .Rest ? "\(workout.restRemaining)" : "set \(workout.currentSet)"
    }
    private var titleColor: Color {
        workout.state == .Rest ? Palette.restText : Palette.activeTitleText
    }
    
    var body: some View {
        ZStack {
            CircleGradient()
                .padding()
                .opacity(0.5)
            ProgressRing(progress: progress, isRest: workout.state == .Rest)
            VStack {
                Text(titleText)
                    .directive1Font()
                    .foregroundColor(titleColor)
                Text("\(setsRemainingString)")
                    .directive2Font()
                    .foregroundColor(Palette.restText)
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: Workout.example)
    }
}
