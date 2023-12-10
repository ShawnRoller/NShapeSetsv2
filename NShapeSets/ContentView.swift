//
//  ContentView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

let ENABLE_LIVE_ACTIVITY = false

struct ContentView: View {
    @StateObject private var activityManager = ActivityManager.shared
    @State private var showingActionSheet = true
    @State private var totalSeconds = 999
    @State private var topPadding: CGFloat = 10
    @ObservedObject private var workout: Workout = Workout.example
    @ObservedObject private var notifications = Notifications.shared
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                renderInfoBar()
                updateLiveActivity()
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
            .onChange(of: showingActionSheet) { _, newValue in
                topPadding = newValue ? 10 : 100
            }
            SetupActionSheet(workout: workout, rest: $workout.rest, rounds: $workout.rounds, isExpanded: $showingActionSheet, onCTAPress: onCTAPress)
        }
    }
    
    func renderInfoBar() -> some View {
        let renderStates: [WorkoutState] = [.Recap, .Rest, .Active]
        return Group {
            if (renderStates.contains(workout.state)) {
                InfoBar(progress: workout.progress, totalSeconds: workout.totalTimer.totalTime)
            } else {
                EmptyView()
            }
        }
    }
    
    func updateLiveActivity() -> some View {
        /*
         LIVE ACTIVITY issues
         - UI for live activity is POC
         - The rest timer doesn't synchronize with the LA timer
         */
        guard ENABLE_LIVE_ACTIVITY == true else { return EmptyView() }
        
        if activityManager.activityID == nil {
            // live activity is not yet started
            Task {
                await activityManager.start(sets: workout.rounds, currentSet: workout.currentSet, rest: workout.rest, state: workout.state)
            }
        }
        else {
            // live activity is started and needs to be updated
            if workout.state == .Done || workout.state == .Recap || workout.state == .Setup {
                Task {
                    await activityManager.cancelAllRunningActivities()
                }
            } else {
                Task {
                    await activityManager.updateActivity(sets: workout.rounds, currentSet: workout.currentSet, rest: workout.rest, state: workout.state)
                }
            }
        }
        return EmptyView()
    }
    
    func onCTAPress() -> Void {
        // Request permission to send push notifications
        notifications.handleNotificationPermission()
        
        // TODO: determine how to stop the total timer when the recap view appears
        // should the total timer be part of the workout?
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
        default:
            break;
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
