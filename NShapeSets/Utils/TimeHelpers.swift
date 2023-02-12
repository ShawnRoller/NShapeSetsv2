//
//  TimeHelpers.swift
//  NShapeSets
//
//  Created by Shawn Roller on 2/12/23.
//

import Foundation

func getTime(from seconds: Int) -> String {
    let minutes = seconds / 60 % 60
    let seconds = seconds % 60
    let time = String(format: "%02i:%02i", minutes, seconds)
    return time
}
