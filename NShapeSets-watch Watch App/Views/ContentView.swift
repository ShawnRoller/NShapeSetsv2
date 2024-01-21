//
//  ContentView.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var healthManager = HealthManager.shared
    @State private var preferredColumn = NavigationSplitViewColumn.detail
    
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List(workouts) {
                NavigationLink($0.name, destination: SetupView(workoutType: $0))
            }
            .navigationTitle {
                Text("Workout Type")
                    .font(.title3)
                    .foregroundStyle(Palette.primary)
            }
        } detail: {
            SetupView()
        }
        .onAppear() {
            healthManager.authorizeHealthKit()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
