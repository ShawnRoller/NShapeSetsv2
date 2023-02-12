//
//  ProgressBar.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/24/23.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Float
    
    var body: some View {
        let background = LinearGradient(gradient: Palette.progressBackgroundGradient, startPoint: .leading, endPoint: .trailing)
        let progressBackground = LinearGradient(gradient: Palette.progressGradient, startPoint: .leading, endPoint: .trailing)
        
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(background)
                    .cornerRadius(.infinity)
                Rectangle()
                    .fill(progressBackground)
                    .cornerRadius(.infinity)
                    .frame(width: CGFloat(progress / 100) * metrics.size.width, height: 6)
                    .animation(Animation.spring(), value: progress)
            }
        }
        .frame(height: 6)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 50)
    }
}
