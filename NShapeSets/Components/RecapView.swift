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
                    
                    RecapDetail(title: "Total sets", value: "\(workout.completedSets)")
                        .listRowBackground(listBackground)
                    
                    RecapDetail(title: "Skipped rest", value: "\(workout.skippedRest)")
                        .listRowBackground(listBackground)
                    
                    RecapDetail(title: "Total time", value: time)
                        .listRowBackground(listBackground)
                    
                    RecapDetail(title: "Total active time", value: activeTime)
                        .listRowBackground(listBackground)
                    
                }
                .padding(.bottom, 100)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct RecapView_Previews: PreviewProvider {
    static var previews: some View {
        RecapView(workout: Workout.example)
    }
}
