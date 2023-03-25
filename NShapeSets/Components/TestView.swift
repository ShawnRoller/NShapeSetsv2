//
//  TestView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct TestView: View {
    var restProgress: CGFloat = 1
    var restColor: Color = Palette.restBar
    var restShadowColor: Color = Palette.restBarShadow
    var restWidth: CGFloat = 20
    
    var activeProgress: CGFloat = 1
    var activeColor: Color = Palette.activeRing
    var activeShadowColor: Color = Palette.activeRing
    var activeWidth: CGFloat = 8
    
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Ring(progress: isActive ? activeProgress : restProgress, color: isActive ? activeColor : restColor, shadowColor: isActive ? activeShadowColor : restShadowColor, width: isActive ? activeWidth : restWidth)
            Button("Toggle") {
                withAnimation(.spring()) {
                    isActive.toggle()
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
