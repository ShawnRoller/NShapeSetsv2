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
    var onEndWorkout: () -> Void
    
    private var buttonTitle: String {
        var title: String
        switch workout.state {
        case .Setup:
            title = "Start"
        case .Active:
            title = workout.currentSet == workout.rounds ? "Done" : "Rest"
        case .Rest:
            title = "Skip"
        case .Recap:
            title = "Setup"
        default:
            title = "Start"
        }
        return title
    }
    
    private var ctaType: CtaType {
        var type: CtaType
        switch workout.state {
        case .Setup:
            type = .primary
        case .Active:
            type = .primary
        case .Rest:
            type = .destructive
        case .Recap:
            type = .secondary
        default:
            type = .primary
        }
        return type
    }
    
    private var showEndWorkout: Bool {
        let endStates: [WorkoutState] = [.Active, .Rest]
        if endStates.contains(workout.state) && isExpanded {
            return true
        }
        return false
    }
    
    var body: some View {
        GeometryReader { proxy in
        ActionSheet(isExpanded: $isExpanded) {
            Main {
                RestSelector(restValue: $rest)
                SetsSelector(setsValue: $rounds, minSet: workout.currentSet)
            }
                Footer {
                    HStack {
                        CTAButton(title: buttonTitle, role: ctaType, action: onCTAPress)
                        CTAButton(title: "Done", role: .destructive, action: onEndWorkout)
                            .frame(width: showEndWorkout ? proxy.size.width / 4 : 0)
                    }
                }
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(workout: Workout.example, rest: .constant(Workout.example.rest), rounds: .constant(Workout.example.rounds), isExpanded: .constant(true), onCTAPress: {}, onEndWorkout: {})
    }
}
