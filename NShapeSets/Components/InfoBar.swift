//
//  InfoBar.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/12/23.
//

import SwiftUI

struct InfoBar: View {
    var progress: Float
    var totalSeconds: Int
    private var time: String {
        return getTime(from: totalSeconds)
    }
    
    var body: some View {
        VStack {
            ProgressBar(progress: progress)
                .padding([.leading, .trailing])
            Label {
                Text(time)
                    .totalTimeFont()
                    .foregroundColor(Palette.quaternary)
            } icon: {
                Image(systemName: "clock.fill")
                    .foregroundColor(Palette.quaternary)
            }
        }
    }
}

struct InfoBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                InfoBar(progress: 33, totalSeconds: 999)
                    .environment(\.colorScheme, .dark)
            }
            .background()
            .environment(\.colorScheme, .dark)
            VStack {
                InfoBar(progress: 33, totalSeconds: 999)
                    .environment(\.colorScheme, .light)
            }
            .background()
            .environment(\.colorScheme, .light)
        }
    }
}
