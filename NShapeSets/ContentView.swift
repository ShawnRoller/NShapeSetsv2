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
    @State private var topPadding: CGFloat = 10
    @State private var restRemaining: CGFloat = 1
    @State private var workout: Workout = Workout.example
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                InfoBar(progress: progress, totalSeconds: totalSeconds)
//                LogoView()
//                    .padding()
//                    .padding(.top, topPadding)
//                    .animation(Animation.spring(), value: topPadding)
                ProgressRing(progress: restRemaining)
                Button("decrement") {
                    restRemaining -= 0.1
                }
                Spacer()
            }
            .onChange(of: showingActionSheet) { value in
                topPadding = value ? 10 : 100
            }
            SetupActionSheet(restValue: $sets, setsValue: $rest, isExpanded: $showingActionSheet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
