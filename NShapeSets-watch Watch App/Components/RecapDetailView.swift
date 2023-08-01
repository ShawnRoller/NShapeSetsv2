//
//  RecapDetailView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 8/1/23.
//

import SwiftUI

struct RecapDetailView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Palette.secondary)
            Spacer()
            Text(value)
                .foregroundStyle(Palette.primary)
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    RecapDetailView(title: "Skipped rest", value: "2")
}
