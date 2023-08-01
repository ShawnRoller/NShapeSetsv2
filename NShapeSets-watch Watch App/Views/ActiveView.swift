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
            InfoBar(progress: 50, totalSeconds: 555, detailColor: .white, detailOnTop: true)
                .padding([.top, .leading, .trailing])
            Spacer()
            ZStack {
                CircleGradient()
                    .padding()
                SetsView(currentSet: 9, totalSets: 15)
            }
//            DetailView(title: "Total time:", value: "\(TimeHelper.getTimeFromSeconds(timer.totalTime))", smallText: true)
//            InstructionView(title: "Current set:", value: "\(timer.currentRound)")
//            Spacer().frame(height:0)
//            DetailView(title: "Remaining:", value: "\(timer.remainingRounds)", smallText: true)
            Spacer()
            PrimaryButton(title: buttonTitle, buttonColor: Palette.secondary) {
                self.onButtonTap()
            }
            .padding(.bottom)
        }
        .ignoresSafeArea(edges: [.bottom, .top])
    }
}

#Preview {
    ActiveView(workout: Workout.example, timer: TimerWrapper.example, onButtonTap: {})
}
