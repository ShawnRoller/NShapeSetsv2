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
    
    /*
     RecapDetailView(title: "Sets", value: "15")
     RecapDetailView(title: "Rest time", value: "12:30")
     RecapDetailView(title: "Total time", value: "31:45")
     RecapDetailView(title: "Skipped rest", value: "2")
         .padding(.top)
     */
    
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
                    
                    Text("Rest time: \(workout.totalRestTime)")
                        .directive2Font()
                        .foregroundColor(Palette.secondary)
                        .listRowBackground(listBackground)
                    
                    Text("Total time: \(time)")
                        .directive2Font()
                        .foregroundColor(Palette.secondary)
                        .listRowBackground(listBackground)
                    
                    Text("Skipped rest: \(workout.skippedRest)")
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
