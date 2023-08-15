//
//  ActiveView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import SwiftUI

struct ActiveView: View {
    var workout: Workout
    @ObservedObject var timer: TimerWrapper
    var onButtonTap: () -> Void
    var remainingSets: String {
        return "\(timer.remainingRounds)"
    }
    
    var buttonTitle: String {
        let remainingRounds = timer.rounds - timer.currentRound
        return remainingRounds > 0 ? "Rest" : "Done"
    }
    
    var body: some View {
        VStack {
            InfoBar(progress: 50, totalSeconds: 555, detailColor: .secondary, detailOnTop: true)
                .padding([.top], 22.0)
                .padding([.leading, .trailing])
            Spacer()
            ZStack {
                CircleGradient()
                    .padding()
                ProgressRing(progress: 100, isRest: false, ringWidth: 5)
                SetsView(currentSet: 9, totalSets: 15)
            }
//            DetailView(title: "Total time:", value: "\(TimeHelper.getTimeFromSeconds(timer.totalTime))", smallText: true)
//            InstructionView(title: "Current set:", value: "\(timer.currentRound)")
//            Spacer().frame(height:0)
//            DetailView(title: "Remaining:", value: "\(timer.remainingRounds)", smallText: true)
            Spacer()
            PrimaryButton(title: buttonTitle, buttonColor: Palette.primary, titleColor: Palette.primaryButtonTitleText) {
                self.onButtonTap()
            }
        }
        .ignoresSafeArea(edges: [.bottom, .top])
    }
}

#Preview {
    ActiveView(workout: Workout.example, timer: TimerWrapper.example, onButtonTap: {})
}
