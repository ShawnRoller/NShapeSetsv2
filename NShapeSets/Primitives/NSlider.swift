//
//  Slider.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/24/23.
//

import SwiftUI

struct NSlider: View {
    @Binding var value: Float
    var range: ClosedRange<Float> = 0...10
    var step: Float = 5
    
    var body: some View {
        Slider(value: $value, in: range, step: step)
            .accentColor(Palette.setsSliderFill)
    }
}

struct NSlider_Previews: PreviewProvider {
    static var previews: some View {
        NSlider(value: .constant(5))
    }
}
