//
//  RecapView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 4/6/23.
//

import SwiftUI

struct RecapView: View {
    var workout: Workout
    
    var body: some View {
        ZStack {
            CircleGradient()
                .padding()
                .opacity(0.5)
            VStack {
                Text("Recap")
                    .directive1Font()
                .foregroundColor(Palette.restText)
                Text("Total time: 3:33")
                    .directive2Font()
                .foregroundColor(Palette.restText)
                Text("Total sets: \(workout.rounds)")
                    .directive2Font()
                    .foregroundColor(Palette.restText)
            }
        }
    }
}

struct RecapView_Previews: PreviewProvider {
    static var previews: some View {
        RecapView(workout: Workout.example)
    }
}
