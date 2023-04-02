//
//  ContentView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = true
    @State private var totalSeconds = 999
    @State private var topPadding: CGFloat = 10
    @State private var workout: Workout = Workout.example
    @State private var showingLogo = false
    private var progress: Float {
        Float(workout.currentSet) / Float(workout.rounds) * 100
    }
    
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
                        WorkoutView(workout: workout)
                    }
                }
                .padding(.top, topPadding)
                .animation(Animation.spring(), value: topPadding)
                .animation(.spring(), value: showingLogo)
                Button("toggle") {
                    workout.state = workout.state == .Rest ? .Active : .Rest
//                    showingLogo.toggle()
                }
                Spacer()
            }
            .onChange(of: showingActionSheet) { value in
                topPadding = value ? 10 : 100
            }
            SetupActionSheet(restValue: $workout.rest, setsValue: $workout.rounds, isExpanded: $showingActionSheet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
