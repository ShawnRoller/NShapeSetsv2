//
//  HapticHelpers.swift
//  NShapeSets
//
//  Created by Shawn Roller on 4/10/23.
//

import SwiftUI

struct Haptic {
    static let generator = UINotificationFeedbackGenerator()
    
    static func light() -> Void {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    static func medium() -> Void {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    static func heavy() -> Void {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    static func selection() -> Void {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    static func success() -> Void {
        Haptic.generator.notificationOccurred(.success)
    }
    static func error() -> Void {
        Haptic.generator.notificationOccurred(.error)
    }
    static func warning() -> Void {
        Haptic.generator.notificationOccurred(.warning)
    }
}
