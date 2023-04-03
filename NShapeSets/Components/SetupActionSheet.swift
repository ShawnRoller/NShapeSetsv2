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
    private var buttonTitle: String {
        var title = "Start"
        switch workout.state {
        case .Setup:
            title = "State"
        case .Active:
            title = "Rest"
        case .Rest:
            title = "Skip"
        case .Recap:
            title = "Done"
        }
        return title
    }
    
    var body: some View {
        ActionSheet(isExpanded: $isExpanded) {
            Main {
                RestSelector(restValue: $workout.rest)
                SetsSelector(setsValue: $workout.rounds)
            }
            Footer {
                CTAButton(title: buttonTitle, action: { isExpanded.toggle() })
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(workout: .constant(Workout.example), isExpanded: .constant(true))
    }
}
