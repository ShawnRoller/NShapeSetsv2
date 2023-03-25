//
//  SetupActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/3/23.
//

import SwiftUI

struct SetupActionSheet: View {
    @Binding var restValue: Int
    @Binding var setsValue: Int
    @Binding var isExpanded: Bool
    
    var body: some View {
        ActionSheet(isExpanded: $isExpanded) {
            Main {
                RestSelector(restValue: $restValue)
                SetsSelector(setsValue: $setsValue)
            }
            Footer {
                CTAButton(title: "Start", action: { isExpanded.toggle() })
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(restValue: .constant(50), setsValue: .constant(50), isExpanded: .constant(true))
    }
}
