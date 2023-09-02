//
//  DefaultManager.swift
//  NShapeSets
//
//  Created by Shawn Roller on 7/18/23.
//

import Foundation
//import WidgetKit

struct DefaultManager {
    static func setDefault(value: Any, forKey key: String) {
        guard let defaults = UserDefaults(suiteName: Constants.appGroup) else { return }
        defaults.set(value, forKey: key)
//        WidgetCenter.shared.reloadTimelines(ofKind: Constants.quickStartWidgetKind)
    }
    
    static func getDefault(forKey key: String) -> Any? {
        guard let defaults = UserDefaults(suiteName: Constants.appGroup) else { return nil }
        let value = defaults.object(forKey: key)
        return value
    }
}
