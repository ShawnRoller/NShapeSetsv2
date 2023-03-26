//
//  ContentView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Float = 50
    @State private var sets: Int = 15
    @State private var rest: Int = 90
    @State private var showingActionSheet = true
    @State private var totalSeconds = 999
    @State private var topPadding: CGFloat = 10
    @State private var restRemaining: Int = 30
    @State private var workout: Workout = Workout.example
    @State private var showingLogo = false
    @State private var currentSet = 4
    @State private var isRest = false
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                InfoBar(progress: progress, totalSeconds: totalSeconds)
                ZStack {
                    if showingLogo {
                        LogoView()
                            .padding()
                            .padding(.top, topPadding)
                            .animation(Animation.spring(), value: topPadding)
                    } else {
                        WorkoutView(workout: workout, currentSet: currentSet, isRest: isRest, restRemaining: restRemaining)
                    }
                }
                .animation(.spring(), value: showingLogo)
                Button("toggle") {
                    isRest.toggle()
                }
                Spacer()
            }
            .onChange(of: showingActionSheet) { value in
                topPadding = value ? 10 : 100
            }
            SetupActionSheet(restValue: $rest, setsValue: $sets, isExpanded: $showingActionSheet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
