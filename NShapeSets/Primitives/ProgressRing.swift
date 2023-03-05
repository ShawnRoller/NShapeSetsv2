//
//  SwiftUIView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/5/23.
//

import SwiftUI

struct ProgressRing: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Palette.restBar, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .animation(.spring(), value: progress)
                .shadow(color: Palette.restBarShadow, radius: 20)
        }
        .padding()
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            ProgressRing(progress: 0.89)
        }
    }
}
