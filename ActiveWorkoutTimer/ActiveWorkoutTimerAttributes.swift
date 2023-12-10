//
//  ActiveWorkoutTimerAttributes.swift
//  NShapeSets
//
//  Created by Shawn Roller on 11/16/23.
//

import ActivityKit
import SwiftUI

struct ActiveWorkoutTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var sets: Int
        var currentSet: Int
        var remainingRest: Int
        var restEndDate: Date {
            return Date.now.addingTimeInterval(TimeInterval(remainingRest))
        }
        var state: WorkoutState
    }

    // Fixed non-changing properties about your activity go here!
    var name = "NShape Sets"
    var sets: Int
}

