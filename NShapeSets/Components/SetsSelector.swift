//
//  SetsSelector.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct SetsSelector: View {
    @Binding var setsValue: Int
    var minSet: Int
    
    var body: some View {
        ValueSelector(value: $setsValue, title: "sets", step: 1.0, range: 1...30)
            .onChange(of: setsValue) { newValue in
                if newValue < minSet {
                    setsValue = minSet
                }
            }
    }
}

struct SetsSelector_Previews: PreviewProvider {
    static var previews: some View {
        SetsSelector(setsValue: .constant(15), minSet: 3)
    }
}
