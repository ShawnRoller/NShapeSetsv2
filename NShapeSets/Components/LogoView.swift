//
//  LogoView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/26/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            CircleGradient()
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text("nshape")
                        .logoSubtitleFont()
                        .offset(x: -40, y: 20)
                        .foregroundColor(Palette.logoSubtitleText)
                }
                Text("Sets")
                    .logoTitleFont()
                    .offset(y: -50)
                    .foregroundColor(Palette.logoTitleText)
                    .shadow(color: Palette.logoTitleTextShadow, radius: 4)
            }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
