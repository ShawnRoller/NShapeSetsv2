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
        Ring(progress: progress, color: Palette.restBar, shadowColor: Palette.restBarShadow, width: 20)
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
