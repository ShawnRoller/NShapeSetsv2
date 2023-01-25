//
//  BackgroundGradient.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        let background = LinearGradient(gradient: Palette.backgroundGradient, startPoint: .top, endPoint: .bottom)
        
        return Rectangle()
            .fill(background)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BackgroundGradient()
                .environment(\.colorScheme, .light)
            
            BackgroundGradient()
                .environment(\.colorScheme, .dark)
        }
    }
}
