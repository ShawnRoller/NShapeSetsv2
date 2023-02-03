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
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                ProgressBar(progress: $progress)
                SetupActionSheet(restValue: $sets, setsValue: $rest)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
