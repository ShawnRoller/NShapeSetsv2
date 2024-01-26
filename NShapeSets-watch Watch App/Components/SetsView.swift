//
//  SetsView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 8/1/23.
//

import SwiftUI

struct SetsView: View {
    var currentSet: Int
    var totalSets: Int
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(currentSet)")
                .font(.largeTitle)
                .foregroundStyle(Palette.primary)
        }
    }
}

#Preview {
    SetsView(currentSet: 9, totalSets: 15)
}
