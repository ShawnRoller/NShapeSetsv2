//
//  OSLogExtensions.swift
//  NShapeSets
//
//  Created by Shawn Roller on 7/18/23.
//

import Foundation
import os

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let healthKit = OSLog(subsystem: subsystem, category: "HealthKit")
}
