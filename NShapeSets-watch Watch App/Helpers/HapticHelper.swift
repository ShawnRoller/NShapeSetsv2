//
//  HapticHelper.swift
//  NShapeSets
//
//  Created by Shawn Roller on 7/18/23.
//

import Foundation
import WatchKit

struct HapticHelper {
    
    static func playCountdownHaptic() {
        WKInterfaceDevice.current().play(.start)
    }
    
    static func playStartHaptic() {
        WKInterfaceDevice.current().play(.success)
    }
}
