//
//  SetupActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/3/23.
//

import SwiftUI

struct SetupActionSheet: View {
    @Binding var restValue: Double
    @Binding var setsValue: Double
    @State private var isExpanded = true
    
    var body: some View {
        ActionSheet(isExpanded: $isExpanded) {
            Main {
                ValueSelector(value: $restValue, title: "rest")
                ValueSelector(value: $setsValue, title: "sets")
            }
            Footer {
                CTAButton(title: "Start", action: { isExpanded.toggle() })
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(restValue: .constant(50), setsValue: .constant(50))
    }
}
