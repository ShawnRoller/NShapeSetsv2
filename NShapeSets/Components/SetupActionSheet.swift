//
//  SetupActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/3/23.
//

import SwiftUI

struct SetupActionSheet: View {
    @Binding var workout: Workout
    @Binding var isExpanded: Bool
    
    var body: some View {
        ActionSheet(isExpanded: $isExpanded) {
            Main {
                RestSelector(restValue: $workout.rest)
                SetsSelector(setsValue: $workout.rounds)
            }
            Footer {
                CTAButton(title: "Start", action: { isExpanded.toggle() })
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(workout: .constant(Workout.example), isExpanded: .constant(true))
    }
}
