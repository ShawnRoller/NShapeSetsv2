//
//  CTAButton.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/7/23.
//

import SwiftUI

enum CtaType {
    case primary
    case secondary
    case destructive
}

struct CTAButton: View {
    let title: String
    var role: CtaType = .primary
    let action: () -> Void
    
    var backgroundColor: Color {
        switch role {
        case .primary:
            return Palette.primaryButtonFill
        case .secondary:
            return Palette.secondaryButtonFill
        case .destructive:
            return Palette.destructiveButtonFill
        }
    }
    
    var borderColor: Color {
        switch role {
        case .primary:
            return Palette.primaryButtonBorder
        case .secondary:
            return Palette.secondaryButtonBorder
        case .destructive:
            return Palette.destructiveButtonBorder
        }
    }
    
    var titleColor: Color {
        switch role {
        case .primary:
            return Palette.primaryButtonTitleText
        case .secondary:
            return Palette.secondaryButtonTitleText
        case .destructive:
            return Palette.destructiveButtonTitleText
        }
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .foregroundColor(titleColor)
                .background(backgroundColor)
                .clipShape(Capsule(style: .continuous))
                .background(
                    Capsule(style: .continuous)
                        .stroke(borderColor, lineWidth: 1)
                )
                .ctaFont()
            
        }
        .shadow(color: Palette.shadow, radius: 4, x: 0, y: 2)
    }
}

struct CTAButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CTAButton(title: "Start", role: CtaType.primary) {}
            CTAButton(title: "Start", role: CtaType.secondary) {}
            CTAButton(title: "Start", role: CtaType.destructive) {}
        }
    }
}
