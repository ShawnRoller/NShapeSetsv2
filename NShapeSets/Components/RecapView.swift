//
//  RecapView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 4/6/23.
//

import SwiftUI

struct RecapView: View {
    var workout: Workout
    private var time: String {
        return getTime(from: workout.totalTimer.totalTime)
    }
    private var activeTime: String {
        return getTime(from: workout.totalTimer.totalTime - workout.totalRestTime)
    }

    var listBackground: some View {
        Color.white.opacity(0)
    }
    
    var body: some View {
        ZStack {
            CircleGradient()
                .padding()
                .opacity(0.5)
            
            VStack {
                List {
                    Section {
                        Text("Recap")
                            .directive1Font()
                            .foregroundColor(Palette.primary)
                            .listRowBackground(Color.white.opacity(0))
                    }
                    
                    Text("Total sets: \(workout.completedSets)")
                        .directive2Font()
                        .foregroundColor(Palette.secondary)
                        .listRowBackground(listBackground)
                    
                    Text("Skipped rest: \(workout.skippedRest)")
                        .directive2Font()
                        .foregroundColor(Palette.secondary)
                        .listRowBackground(listBackground)
                    
                    Text("Total time: \(time)")
                        .directive2Font()
                        .foregroundColor(Palette.secondary)
                        .listRowBackground(listBackground)
                    
                    Text("Total active time: \(activeTime)")
                        .directive2Font()
                        .foregroundColor(Palette.secondary)
                        .listRowBackground(listBackground)
                }
                .padding(.bottom, 100)
                .scrollContentBackground(.hidden)
            }
            
//            VStack {
//                Text("Recap")
//                    .directive1Font()
//                    .foregroundColor(Palette.restText)
//                Text("Total time: \(time)")
//                    .directive2Font()
//                    .foregroundColor(Palette.primary)
//                Text("Total sets: \(workout.rounds)")
//                    .directive2Font()
//                    .foregroundColor(Palette.primary)
//            }
        }
    }
}

struct RecapView_Previews: PreviewProvider {
    static var previews: some View {
        RecapView(workout: Workout.example)
    }
}
