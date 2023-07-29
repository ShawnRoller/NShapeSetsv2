//
//  RestView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import SwiftUI

struct RestView: View {
    var workout: Workout
    @ObservedObject var timer: TimerWrapper
    var onButtonTap: () -> Void
    
    var body: some View {
        VStack {
            DetailView(title: "Total time:", value: "\(TimeHelper.getTimeFromSeconds(timer.totalTime))", smallText: true)
            InstructionView(title: "Resting...", value: "\(timer.remainingRest)", countdownTotal: timer.rest, currentCountdown: timer.remainingRest)
            Spacer()
            DetailView(title: "Next set:", value: "\(timer.nextSetString)", smallText: true)
            Spacer().frame(height: 0)
            PrimaryButton(title: "Skip", buttonColor: Palette.primary) {
                self.onButtonTap()
            }
        }
    }
}

#Preview {
    RestView(workout: Workout.example, timer: TimerWrapper.example, onButtonTap: {})
}
