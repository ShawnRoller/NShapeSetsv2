//
//  NShapeSetsApp.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

@main
struct NShapeSetsApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HealthManager.shared)
                .environmentObject(Notifications.shared)
                .onChange(of: scenePhase) { _, phase in
                    Notifications.shared.handleAppState(phase)
                }
                .preferredColorScheme(.dark)
        }
    }
}
