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
    var currentSet: Int?
    var totalSets: Int?
    
    private var time: String {
        return getTime(from: totalSeconds)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            topView()
            bottomView()
        }
    }
    
    func setsView() -> some View {
        Group {
            if let currentSet, let totalSets {
                Text("\(currentSet)/\(totalSets)")
                    .totalTimeFont()
                    .foregroundColor(Palette.primary)
            } else {
                EmptyView()
            }
        }
    }
    
    func topView() -> some View {
        Group {
            if (detailOnTop) {
                HStack {
                    Spacer()
                    Label {
                        Text(time)
                            .totalTimeFont()
                            .foregroundColor(detailColor)
                    } icon: {
                        Image(systemName: "clock.fill")
                            .foregroundColor(detailColor)
                    }
                    .padding(.leading)
                    .labelStyle(.titleOnly)
                    Spacer()
                        .overlay {
                            setsView()
                        }
                }
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
            VStack {
                InfoBar(progress: 33, totalSeconds: 999, detailOnTop: true, currentSet: 10, totalSets: 12)
                    .environment(\.colorScheme, .dark)
            }
            .background()
            .environment(\.colorScheme, .dark)
        }
    }
}
