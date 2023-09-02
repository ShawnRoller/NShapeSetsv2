//
//  StateModels.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import Foundation

enum ScreenState: String {
    case setup = "setup"
    case active = "active"
    case rest = "rest"
    case complete = "complete"
}

enum ActiveAlert {
    case done, back
}
