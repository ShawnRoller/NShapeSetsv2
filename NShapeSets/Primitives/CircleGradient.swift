//
//  CircleGradient.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/25/23.
//

import SwiftUI

struct CircleGradient: View {
    var body: some View {
        GeometryReader() { metric in
            let background = RadialGradient(colors: Palette.logoCircularGradientColors, center: .center, startRadius: 0, endRadius: metric.size.width)
            Circle()
                .fill(background)
        }
    }
}

struct CircleGradient_Previews: PreviewProvider {
    static var previews: some View {
        CircleGradient()
    }
}
