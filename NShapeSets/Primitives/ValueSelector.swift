//
//  ValueSelector.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/9/23.
//

import SwiftUI

struct ValueSelector: View {
    @Binding var value: Int
    var title = "sets"
    var step: Double = 1
    var range: ClosedRange<Double> = 1...100
    var isTime = false
    
    var valueTitle: String {
        self.isTime ? getTime(from: value) : "\(value)"
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text("\(valueTitle)")
                    .selectorTitleFont()
                    .foregroundColor(Palette.quaternary)
                Text(title)
                    .selectorSubtitleFont()
                    .foregroundColor(Palette.primary)
            }
            CustomSlider(range: range, step: step, value: Binding<Double>(
                get: { Double(value) },
                set: { value = Int($0) }
            ))
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
