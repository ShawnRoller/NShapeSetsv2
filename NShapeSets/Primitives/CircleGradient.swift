//
//  CircleGradient.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/25/23.
//

import SwiftUI

struct CircleGradient: View {
    var body: some View {
            let background = RadialGradient(colors: Palette.logoCircularGradientColors, center: .center, startRadius: 0, endRadius: 200)
            
                Circle()
                    .fill(background)
    }
}

struct CircleGradient_Previews: PreviewProvider {
    static var previews: some View {
        CircleGradient()
    }
}
