//
//  Typography.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/21/23.
//

import SwiftUI

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
    func ctaFont() -> some View {
        return self.modifier(ScaledFont(name: "AXR ArcadeMachine", size:60)).baselineOffset(12)
    }
    func logoTitleFont() -> some View {
        return self.modifier(ScaledFont(name: "AXR ArcadeMachine", size:180)).baselineOffset(12)
    }
    func logoSubtitleFont() -> some View {
        return self.modifier(ScaledFont(name: "AXR ArcadeMachine", size:90)).baselineOffset(12)
    }
    func selectorTitleFont() -> some View {
        return self.modifier(ScaledFont(name: "Karla", size:30))
    }
    func selectorSubtitleFont() -> some View {
        return self.modifier(ScaledFont(name: "Karla", size:13))
    }
    func totalTimeFont() -> some View {
        return self.modifier(ScaledFont(name: "Karla", size:13))
    }
    func directive1Font() -> some View {
        return self.modifier(ScaledFont(name: "AXR ArcadeMachine", size:150)).baselineOffset(12)
    }
    func directive2Font() -> some View {
        return self.modifier(ScaledFont(name: "AXR ArcadeMachine", size:60)).baselineOffset(12)
    }
    func watchCtaFont() -> some View {
        return self.modifier(ScaledFont(name: "AXR ArcadeMachine", size:50)).baselineOffset(10)
    }
//    func watchInputFont() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:26))
//    }
//    func watchHeader1Font() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:40))
//    }
//    func watchHeader2Font() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:35))
//    }
//    func watchTitleFont() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:12))
//    }
//    func watchInstructionFont() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:38))
//    }
//    func watchTimerFont() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:30))
//    }
//    func watchInstructionTitleFont() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size:22))
//    }
    func watchInstructionDetailFont(withSmallText smallText: Bool = false) -> some View {
        let size: CGFloat = smallText ? 12 : 17
        return self.modifier(ScaledFont(name: "Gotham-Book", size:size))
    }
//    func widgetInfoFont() -> some View {
//        return self.modifier(ScaledFont(name: "Gotham-Book", size: 20))
//    }
}

