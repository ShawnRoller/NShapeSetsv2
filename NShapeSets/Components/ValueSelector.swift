//
//  ValueSelector.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/9/23.
//

import SwiftUI

struct ValueSelector: View {
    @Binding var value: Double
    var title = "sets"
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text("\(value, specifier: "%.0f")")
                    .selectorTitleFont()
                    .foregroundColor(Palette.quaternary)
                Text(title)
                    .selectorSubtitleFont()
                    .foregroundColor(Palette.primary)
            }
            CustomSlider(value: $value)
        }
    }
}

struct ValueSelector_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ValueSelector(value: .constant(50))
                .environment(\.colorScheme, .dark)
            ValueSelector(value: .constant(50))
                .environment(\.colorScheme, .light)
        }
    }
}
