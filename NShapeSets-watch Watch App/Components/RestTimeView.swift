//
//  RestTimeView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 8/1/23.
//

import SwiftUI

struct RestTimeView: View {
    var remainingTime: Int
    
    var body: some View {
        Text("\(remainingTime)")
            .font(.largeTitle)
            .foregroundStyle(Palette.secondary)
    }
}

#Preview {
    RestTimeView(remainingTime: 40)
}
