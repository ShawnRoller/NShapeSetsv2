//
//  NotificationHelpers.swift
//  NShapeSets
//
//  Created by Shawn Roller on 9/2/23.
//

import Foundation
import UserNotifications

final class Notifications: ObservableObject {
    static let shared = Notifications()
    private var enabled = false
    
    func handleNotificationPermission() -> Void {
        // Check if notifications are enabled
        // If enabled do nothing
        // If not enabled
        // if we previously asked, send them to settings app to turn on
        // otherwise show the initial notification prompt
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                self.enabled = true
            } else if let error = error {
                print("[Notifications] - Error: \(error.localizedDescription)")
                self.enabled = false
            }
        }
    }
}
