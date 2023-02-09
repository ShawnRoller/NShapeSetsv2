//
//  ActionSheet.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/29/23.
//

import SwiftUI

typealias Main<V> = Group<V> where V:View
typealias Footer<V> = Group<V> where V:View

struct ActionSheet<View1, View2>: View where View1: View, View2: View {
    var content: () -> TupleView<(Main<View1>, Footer<View2>)>
    @State private var offset: CGFloat = 0
    @Binding var isExpanded: Bool
    
    init(isExpanded: Binding<Bool>, @ViewBuilder content: @escaping () -> TupleView<(Main<View1>, Footer<View2>)>) {
        self.content = content
        self._isExpanded = isExpanded
    }
    
    let maxHeight: CGFloat = 314
    let minHeight: CGFloat = 114
    var maxOffset: CGFloat {
        return maxHeight - minHeight
    }
    var pivotPoint: CGFloat {
        return maxOffset / 2
    }
    let overshot: CGFloat = 10
    
    fileprivate func setOffset(expanded: Bool) {
        if expanded {
            offset = 0
            isExpanded = true
        } else {
            offset = maxOffset
            isExpanded = false
        }
    }
    
    fileprivate func grabber() -> some View {
        return HStack {
            Spacer()
            Capsule()
                .frame(width: 36, height: 10)
                .foregroundColor(Palette.actionSheetGradientColors.last)
                .padding(8)
                .contentShape(Rectangle())
            Spacer()
        }
        .frame(height: 6)
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
                        setOffset(expanded: false)
                    } else {
                        setOffset(expanded: true)
                    }
                }
        )
        .onChange(of: isExpanded) { value in
            setOffset(expanded: value)
        }
        .onAppear {
            self.offset = isExpanded ? 0 : maxOffset
        }
    }
    
    var body: some View {
        let (main, footer) = content().value
        
        ZStack {
            VStack {
                Spacer()
                VStack {
                    grabber()
                    main
                        .opacity(2 - Double(abs(offset / 30)))
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: minHeight,
                       maxHeight: maxHeight)
                .background(Palette.actionSheetGradient)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea()
            .offset(y: offset + (overshot * 2))
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0.5), value: offset)
            VStack {
                Spacer()
                footer
                    .offset(y: 10)
            }
            .padding()
        }
    }
}

struct ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActionSheet(isExpanded: .constant(true)) {
                Main {
                    Text("213")
                }
                Footer {
                    CTAButton(title: "Start", action: {})
                }
            }
            ActionSheet(isExpanded: .constant(false)) {
                Main {
                    Text("213")
                }
                Footer {
                    CTAButton(title: "Start", action: {})
                }
            }
        }
    }
}
