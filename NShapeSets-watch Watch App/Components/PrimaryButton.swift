//
//  PrimaryButton.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var buttonColor: Color = Palette.secondaryButtonFill
    var onButtonTap: () -> Void
    
    var body: some View {
        Button(action: {
            self.onButtonTap()
        }, label: {
            Text(title)
//                .watchInputFont()
        })
            .background(buttonColor)
            .cornerRadius(100)
    }
}

#Preview {
    PrimaryButton(title: "REST", buttonColor: Palette.primary, onButtonTap: {})
}
