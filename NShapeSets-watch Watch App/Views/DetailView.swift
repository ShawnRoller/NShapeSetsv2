//
//  DetailView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import SwiftUI

struct DetailView: View {
    var title: String
    var value: String
    var smallText = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Palette.primary)
                .watchInstructionDetailFont(withSmallText: self.smallText)
            Text(value)
                .foregroundColor(Palette.secondary)
                .watchInstructionDetailFont(withSmallText: self.smallText)
        }
    }
}

#Preview {
    DetailView(title: "Remaining sets:", value: "99", smallText: true)
}
