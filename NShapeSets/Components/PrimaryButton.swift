//
//  PrimaryButton.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/24/23.
//

import SwiftUI

struct PrimaryButton: View {
    var body: some View {
        CTAButton(title: "test", role: .secondary) {
            print("test")
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton()
    }
}
