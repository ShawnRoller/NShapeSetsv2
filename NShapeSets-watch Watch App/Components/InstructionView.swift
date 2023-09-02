//
//  InstructionView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import SwiftUI

struct InstructionView: View {
    var title: String
    var value: String
    var countdownTotal: Int?
    var currentCountdown: Int?
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(Palette.primary)
//                .watchInstructionTitleFont()
            ZStack {
                if let countdownTotal = countdownTotal, let currentCountdown = currentCountdown {
//                    CircleTimerView(roundTime: countdownTotal, currentTime: currentCountdown, backgroundColor: Palette.secondary, foregroundColor: Palette.primary, circleWidth: 4, progressLineWidth: 3)
                    ProgressRing(progress: CGFloat(currentCountdown / countdownTotal), isRest: countdownTotal > 0, ringWidth: 3)
                        .frame(width: 80, height: 80)
                    
                }
            Text(value)
                    .foregroundColor(Palette.secondary)
//                .watchTimerFont()
            }
        }
    }
}

#Preview {
    InstructionView(title: "Current set", value: "99", countdownTotal: 100, currentCountdown: 75)
}
