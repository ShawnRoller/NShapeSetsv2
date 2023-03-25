//
//  Ring.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct Ring: View {
    var progress: CGFloat = 1
    var color: Color = Palette.restBar
    var shadowColor: Color = Palette.restBarShadow
    var width: CGFloat = 20
    
    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
            .rotationEffect(Angle(degrees: -90))
            .animation(.spring(), value: progress)
            .shadow(color: shadowColor, radius: 20)
            .padding()
    }
}

struct Ring_Previews: PreviewProvider {
    static var previews: some View {
        Ring()
    }
}
