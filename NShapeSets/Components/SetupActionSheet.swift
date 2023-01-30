//
//  SetupActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/30/23.
//

import SwiftUI

struct SetupActionSheet<Content: View>: View {
    @Binding var isVisible: Bool
    var content: () -> Content
    
    init(isVisible: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self._isVisible = isVisible
    }
    
    var body: some View {
        ActionSheet(content: content)
    }
}

struct SetupActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        SetupActionSheet(isVisible: .constant(true)) {
            Text("Hello world")
        }
    }
}
