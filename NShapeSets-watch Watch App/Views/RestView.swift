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
            InfoBar(progress: 50, totalSeconds: 555, detailColor: .secondary, detailOnTop: true)
                .padding([.top], 22.0)
                .padding([.leading, .trailing])
            Spacer()
            ZStack {
                CircleGradient()
                    .padding()
                ProgressRing(progress: 70, isRest: true, ringWidth: 5)
                RestTimeView(remainingTime: 40)
            }
//            DetailView(title: "Total time:", value: "\(TimeHelper.getTimeFromSeconds(timer.totalTime))", smallText: true)
//            InstructionView(title: "Resting...", value: "\(timer.remainingRest)", countdownTotal: timer.rest, currentCountdown: timer.remainingRest)
//            Spacer()
//            DetailView(title: "Next set:", value: "\(timer.nextSetString)", smallText: true)
//            Spacer().frame(height: 0)
            Spacer()
            PrimaryButton(title: "Skip", buttonColor: Palette.tertiary) {
                self.onButtonTap()
            }
        }
        .ignoresSafeArea(edges: [.bottom, .top])
    }
}

#Preview {
    RestView(workout: Workout.example, timer: TimerWrapper.example, onButtonTap: {})
}
