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
    @ObservedObject private var workout: Workout = Workout.example
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                renderInfoBar()
                ZStack {
                    if workout.state == .Setup {
                        LogoView()
                            .padding()
                            .padding(.top, topPadding)
                            .animation(Animation.spring(), value: topPadding)
                    } else if workout.state == .Recap {
                        RecapView(workout: workout)
                    } else {
                        WorkoutView(workout: workout)
                    }
                }
                .padding(.top, topPadding)
                .animation(Animation.spring(), value: topPadding)
                Spacer()
            }
            .onChange(of: showingActionSheet) { value in
                topPadding = value ? 10 : 100
            }
            SetupActionSheet(workout: workout, rest: $workout.rest, rounds: $workout.rounds, isExpanded: $showingActionSheet, onCTAPress: onCTAPress)
        }
    }
    
    func renderInfoBar() -> some View {
        let renderStates: [WorkoutState] = [.Recap, .Rest, .Active]
        return Group {
            if (renderStates.contains(workout.state)) {
                InfoBar(progress: workout.progress, totalSeconds: totalSeconds)
            } else {
                EmptyView()
            }
        }
    }
    
    func onCTAPress() -> Void {
        var setupVisible = false
        switch workout.state {
        case .Setup:
            workout.startWorkout()
        case .Active:
            workout.startRest()
        case .Rest:
            workout.nextSet()
        case .Recap:
            workout.reset()
            setupVisible = true
        }
        
        showingActionSheet = setupVisible
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
