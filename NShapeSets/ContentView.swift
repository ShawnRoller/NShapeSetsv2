//
//  ContentView.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Float = 50
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            ProgressBar(progress: $progress)
            CTAButton(title: "Start") {
                progress += 5
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
