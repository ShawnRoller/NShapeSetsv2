//
//  NShapeSets_watchApp.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 6/8/23.
//

import SwiftUI

@main
struct NShapeSets_watch_Watch_AppApp: App {
    @State private var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(workoutManager)
        }
    }
}
