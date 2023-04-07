//
//  SetupActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/3/23.
//

import SwiftUI

struct SetupActionSheet: View {
    var workout: Workout
    @Binding var rest: Int
    @Binding var rounds: Int
    @Binding var isExpanded: Bool
    var onCTAPress: () -> Void
    
    private var buttonTitle: String {
        var title = "Start"
        switch workout.state {
        case .Setup:
            title = "Start"
        case .Active:
            title = workout.currentSet == workout.rounds ? "Done" : "Rest"
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
                RestSelector(restValue: $rest)
                SetsSelector(setsValue: $rounds, minSet: workout.currentSet)
            }
            Footer {
                CTAButton(title: buttonTitle, action: onCTAPress)
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(workout: Workout.example, rest: .constant(Workout.example.rest), rounds: .constant(Workout.example.rounds), isExpanded: .constant(true), onCTAPress: {})
    }
}
