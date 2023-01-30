//
//  ActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/29/23.
//

import SwiftUI

struct ActionSheet<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(content: content)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 50,
                   maxHeight: 400)
            .background(Palette.actionSheetGradient)
            .cornerRadius(80, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
    }
}

struct ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheet {
            Text("testing123")
        }
    }
}
