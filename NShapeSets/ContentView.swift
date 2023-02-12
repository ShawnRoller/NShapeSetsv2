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
    @State private var totalSeconds = 999
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                InfoBar(progress: progress, totalSeconds: totalSeconds)
                LogoView()
                    .padding()
                Spacer()
            }
            SetupActionSheet(restValue: $sets, setsValue: $rest)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
