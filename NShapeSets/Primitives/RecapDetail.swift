//
//  RecapDetail.swift
//  NShapeSets
//
//  Created by Shawn Roller on 12/30/23.
//

import SwiftUI

struct RecapDetail: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .directive2Font()
                .foregroundColor(Palette.secondary)
            Spacer()
            Text(value)
                .directive2Font()
                .foregroundColor(Palette.primary)
        }
    }
}

#Preview {
    RecapDetail(title: "Total time", value: "00:30")
}
