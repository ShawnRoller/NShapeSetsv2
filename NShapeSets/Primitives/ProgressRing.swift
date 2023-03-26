//
//  SwiftUIView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/5/23.
//
//  The Ring should respond to an "active" or "rest" state
//  Active = red ring, Rest = yellow ring
//  Rest will also accept progress
//  Need to take in whether rest or active, and if rest, take in progress as well

import SwiftUI

struct ProgressRing: View {
    var progress: CGFloat
    var isRest: Bool
    
    private var restProgress: CGFloat {
        isRest ? progress : 1.0
    }
    private var color: Color {
        isRest ? Palette.restBar : Palette.activeRing
    }
    private var shadowColor: Color {
        isRest ? Palette.restBarShadow : Palette.activeRing
    }
    private var width: Double {
        isRest ? 20 : 6
    }
    
    var body: some View {
        Ring(progress: restProgress, color: color, shadowColor: shadowColor, width: width)
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            ProgressRing(progress: 0.89, isRest: true)
        }
    }
}
