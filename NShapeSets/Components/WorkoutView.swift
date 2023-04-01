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
    var workout: Workout
    var currentSet: Int
    var isRest: Bool
    var restRemaining: Int
    private var progress: CGFloat {
        CGFloat(restRemaining) / CGFloat(workout.rest)
    }
    private var setsRemainingString: String {
        let remaining = workout.rounds - currentSet
        
        return remaining == 0 ? "final set" :
               remaining == 1 ? "1 set left" :
               "\(remaining) sets left"
    }
    private var titleText: String {
        isRest ? "\(restRemaining)" : "set \(currentSet)"
    }
    
    func renderContent() -> some View {
        VStack {
            if isRest {
                Text("\(restRemaining)")
                    .directive1Font()
                    .foregroundColor(Palette.activeTitleText)
            } else {
                Text("set \(currentSet)")
                    .directive1Font()
                    .foregroundColor(Palette.restText)
                Text("\(setsRemainingString)")
                    .directive2Font()
                    .foregroundColor(Palette.restText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            CircleGradient()
                .padding()
                .opacity(0.5)
            ProgressRing(progress: progress, isRest: isRest)
            VStack {
                Text(titleText)
                    .directive1Font()
                .foregroundColor(Palette.restText)
                Text("\(setsRemainingString)")
                    .directive2Font()
                    .foregroundColor(Palette.restText)
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: Workout.example, currentSet: 3, isRest: false, restRemaining: Workout.example.rest / 3)
    }
}
