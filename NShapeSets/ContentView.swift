//
//  ContentView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Float = 50
    @State private var sets: Double = 50
    @State private var rest: Double = 50
    @State private var showingActionSheet = true
    @State private var topPadding: CGFloat = 10
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            ProgressBar(progress: $progress)
            VStack {
                LogoView()
                    .padding()
                    .padding(.top, topPadding)
                    .animation(Animation.spring(), value: topPadding)
                Spacer()
            }
            .onChange(of: showingActionSheet) { value in
                print("changing value: \(value)")
                topPadding = value ? 10 : 100
            }
            SetupActionSheet(restValue: $sets, setsValue: $rest, isExpanded: $showingActionSheet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
