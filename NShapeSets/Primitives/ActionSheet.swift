//
//  ActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/29/23.
//

import SwiftUI

struct ActionSheet<Content: View>: View {
    var content: () -> Content
    @State private var offset: CGFloat = 0
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Capsule()
                            .frame(width: 36, height: 10)
                            .foregroundColor(Palette.actionSheetGradientColors.last)
                        Spacer()
                    }
                    .frame(height: 30)
                    .offset(y: -10)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged { value in
                                print("on change value: \(value)")
                                print("on change \(value.translation.height)")
                                if value.translation.height > 0 {
                                    offset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                print("on ended value: \(value)")
                                if value.translation.height > 150 {
                                    offset = 275
                                } else {
                                    offset = 0
                                }
                            }
                    )
                    Spacer()
                    content()
                }
                    .padding()
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 50,
                           maxHeight: 400)
                    .background(Palette.actionSheetGradient)
                    .cornerRadius(50, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
        .offset(y: offset)
        .animation(.easeInOut, value: offset)
    }
}

struct ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheet {
            Text("testing123")
        }
    }
}
