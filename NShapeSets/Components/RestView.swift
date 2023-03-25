//
//  RestView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct RestView: View {
    var restTime: Int
    var restRemaining: Int
    private var progress: CGFloat {
        return CGFloat(restRemaining) / CGFloat(restTime)
    }
    
    
    var body: some View {
        ZStack {
            ProgressRing(progress: progress)
            Text("\(restRemaining)")
                .logoTitleFont()
                .foregroundColor(Palette.restText)
        }
    }
}

struct RestView_Previews: PreviewProvider {
    static var previews: some View {
        RestView(restTime: 90, restRemaining: 60)
            .environment(\.colorScheme, .dark)
    }
}
