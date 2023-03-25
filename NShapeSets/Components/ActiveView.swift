//
//  ActiveView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct ActiveView: View {
    var workout: Workout = Workout.example
    var currentSet: Int = 1
    var setsRemaining: Int {
        workout.rounds - currentSet
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Set \(currentSet)")
                    .ctaFont()
                Text("\(setsRemaining) sets remaining")
                    .ctaFont()
            }
            ActiveRing()
        }
    }
}

struct ActiveView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveView()
    }
}
