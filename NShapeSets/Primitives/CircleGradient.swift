//
//  CircleGradient.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/25/23.
//

import SwiftUI

struct CircleGradient: View {
    @State private var startTime = Date.now
    
    var body: some View {
            let background = RadialGradient(colors: Palette.logoCircularGradientColors, center: .center, startRadius: 0, endRadius: 200)
            
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            Circle()
                .fill(background)
                .drawingGroup()
                .distortionEffect(
                    ShaderLibrary.wave(
                        .float(elapsedTime),
                        .float(5),
                        .float(20),
                        .float(2)
                    ),
                    maxSampleOffset: .zero
                )
        }
    }
}

struct CircleGradient_Previews: PreviewProvider {
    static var previews: some View {
        CircleGradient()
    }
}
