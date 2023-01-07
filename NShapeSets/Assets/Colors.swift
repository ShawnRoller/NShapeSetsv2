//
//  Colors.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/7/23.
//

import SwiftUI
import Foundation

let circularGradientInner = "CircularGradientInner"
let circularGradientOuter = "CircularGradientOuter"
let horizontalGradientStart = "HorizontalGradientStart"
let horizontalGradientEnd = "HorizontalGradientEnd"
let horizontalGradientSecondaryStart = "HorizontalGradientSecondaryStart"
let horizontalGradientSecondaryEnd = "HorizontalGradientSecondaryEnd"
let primaryColor = "PrimaryColor"
let secondaryColor = "SecondaryColor"
let tertiaryColor = "TertiaryColor"
let quaternaryColor = "QuaternaryColor"
let verticalGradientTop = "VerticalGradientTop"
let verticalGradientBottom = "VerticalGradientBottom"
let verticalGradientSecondaryTop = "VerticalGradientSecondaryTop"
let verticalGradientSecondaryBottom = "VerticalGradientSecondaryBottom"

struct Palette {
    static let backgroundGradientColors = [Color(verticalGradientTop), Color(verticalGradientBottom)]
    static let backgroundGradient = Gradient(colors: Palette.backgroundGradientColors)
    
    static let actionSheetGradientColors = [Color(verticalGradientSecondaryTop), Color(verticalGradientSecondaryBottom)]
    static let actionSheetGradient = Gradient(colors: Palette.actionSheetGradientColors)
    
    static let progressGradientColors = [Color(horizontalGradientStart), Color(horizontalGradientEnd)]
    static let progressGradient = Gradient(colors: Palette.progressGradientColors)
    static let progressShadow = Color(secondaryColor)
    
    static let progressBackgroundGradientColors = [Color(horizontalGradientStart), Color(horizontalGradientEnd)]
    static let progressBackgroundGradient = Gradient(colors: Palette.progressBackgroundGradientColors)
    
    static let primaryButtonFill = Color(primaryColor)
    static let primaryButtonBorder = Color(tertiaryColor)
    static let primaryButtonTitleText = Color(tertiaryColor)
    
    static let secondaryButtonFill = Color(tertiaryColor)
    static let secondaryButtonBorder = Color(secondaryColor)
    static let secondaryButtonTitleText = Color(primaryColor)
    
    static let destructiveButtonFill = Color(secondaryColor)
    static let destructiveButtonBorder = Color(tertiaryColor)
    static let destructiveButtonTitleText = Color(quaternaryColor)
    
    static let restBar = Color(primaryColor)
    static let restBarShadow = Color(primaryColor)
    static let restText = Color(secondaryColor)
    static let restCircularGradientColors = [Color(circularGradientInner), Color(circularGradientOuter)]
    static let restCircularGradient = RadialGradient(colors: restCircularGradientColors, center: UnitPoint(x: 0, y: 0), startRadius: 0, endRadius: 0)
    
    static let logoTitleText = Color(primaryColor)
    static let logoTitleTextShadow = Color(primaryColor)
    static let logoSubtitleText = Color(secondaryColor)
    static let logoCircularGradientColors = [Color(circularGradientInner), Color(circularGradientOuter)]
    static let logoCircularGradient = RadialGradient(colors: logoCircularGradientColors, center: UnitPoint(x: 0, y: 0), startRadius: 0, endRadius: 0)
    
    static let activeRing = Color(secondaryColor)
    static let activeTitleText = Color(secondaryColor)
    static let activeSubtitleText = Color(quaternaryColor)
    static let activeCircularGradientColors = [Color(circularGradientInner), Color(circularGradientOuter)]
    static let activeCircularGradient = RadialGradient(colors: activeCircularGradientColors, center: UnitPoint(x: 0, y: 0), startRadius: 0, endRadius: 0)
    
    static let restSliderFill = Color(secondaryColor)
    static let restSliderBackground = Color(tertiaryColor)
    static let restSliderKnob = Color(primaryColor)
    
    static let setsSliderFill = Color(secondaryColor)
    static let setsSliderBackground = Color(tertiaryColor)
    static let setsSliderKnob = Color(primaryColor)
}
