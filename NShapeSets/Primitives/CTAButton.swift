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
    let action: () -> Void
    let role: CtaType = .primary
    
    var backgroundColor: Color {
        switch role {
        case .primary:
            return Palette.primaryButtonFill
        default:
            return Palette.primaryButtonFill
        }
    }
    
    var borderColor: Color {
        switch role {
        case .primary:
            return Palette.primaryButtonBorder
        default:
            return Palette.primaryButtonBorder
        }
    }
    
    var titleColor: Color {
        switch role {
        case .primary:
            return Palette.primaryButtonTitleText
        default:
            return Palette.primaryButtonTitleText
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
        CTAButton(title: "Start") {}
    }
}
