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
    @State private var isExpanded = true
    
    let maxOffset: CGFloat = 275
    let pivotPoint: CGFloat = 150
    let overshot: CGFloat = 10
    
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
                            .padding(10)
                            .contentShape(Rectangle())
                        Spacer()
                    }
                    .frame(height: 30)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged { value in
                                if isExpanded && value.translation.height > 0 {
                                    offset = value.translation.height
                                } else if !isExpanded && value.translation.height < 0 {
                                    let newOffset = maxOffset + value.translation.height
                                    offset = max(newOffset, -overshot)
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > pivotPoint {
                                    offset = maxOffset
                                    isExpanded = false
                                } else {
                                    offset = 0
                                    isExpanded = true
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
        .offset(y: offset + (overshot * 2))
        .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0.5), value: offset)
    }
}

struct ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheet {
            Text("testing123")
        }
    }
}
