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
        HStack {
            Spacer()
            Text("\(currentSet)")
                .font(.largeTitle)
                .foregroundStyle(Palette.primary)
            Spacer()
                .overlay(
                    HStack {
                        Text("/ \(totalSets)")
                            .padding(.leading, 26.0)
                        Spacer()
                    }
                )
        }
    }
}

#Preview {
    SetsView(currentSet: 9, totalSets: 15)
}
