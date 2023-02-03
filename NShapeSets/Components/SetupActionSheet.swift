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
    
    var body: some View {
        ActionSheet {
            Main {
                CustomSlider(value: $restValue)
                CustomSlider(value: $setsValue)
            }
            Footer {
                CTAButton(title: "Start", action: {})
            }
        }
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(restValue: .constant(50), setsValue: .constant(50))
    }
}
