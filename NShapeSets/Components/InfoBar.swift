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
    var detailColor: Color = Palette.quaternary
    var detailOnTop = false
    private var time: String {
        return getTime(from: totalSeconds)
    }
    
    var body: some View {
        VStack(alignment: detailOnTop ? .leading : .center) {
            topView()
            bottomView()
        }
    }
    
    func topView() -> some View {
        Group {
            if (detailOnTop) {
                Label {
                    Text(time)
                        .totalTimeFont()
                        .foregroundColor(detailColor)
                } icon: {
                    Image(systemName: "clock.fill")
                        .foregroundColor(detailColor)
                }
                .padding(.leading)
            } else {
                ProgressBar(progress: progress)
                    .padding([.leading, .trailing])
            }
        }
    }
    
    func bottomView() -> some View {
        Group {
            if (detailOnTop) {
                ProgressBar(progress: progress)
                    .padding([.leading, .trailing])
            } else {
                Label {
                    Text(time)
                        .totalTimeFont()
                        .foregroundColor(detailColor)
                } icon: {
                    Image(systemName: "clock.fill")
                        .foregroundColor(detailColor)
                }
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
