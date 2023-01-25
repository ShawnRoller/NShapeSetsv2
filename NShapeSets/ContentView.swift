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
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                ProgressBar(progress: $progress)
                CustomSlider(value: $sets)
                CustomSlider(value: $rest)
                CTAButton(title: "Start") {
                    progress += 5
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
