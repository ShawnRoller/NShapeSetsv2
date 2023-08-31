//
//  RecapView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 8/1/23.
//

import SwiftUI

struct RecapView: View {
    var body: some View {
        VStack {
            ScrollView {
                RecapDetailView(title: "Sets", value: "15")
                RecapDetailView(title: "Rest time", value: "12:30")
                RecapDetailView(title: "Total time", value: "31:45")
                RecapDetailView(title: "Skipped rest", value: "2")
                    .padding(.top)
            }
        }
    }
}

#Preview {
    RecapView()
}
