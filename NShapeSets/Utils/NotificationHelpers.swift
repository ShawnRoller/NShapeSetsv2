//
//  NotificationHelpers.swift
//  NShapeSets
//
//  Created by Shawn Roller on 9/2/23.
//

import SwiftUI
import UserNotifications

class AppState: ObservableObject {
    @Published var inForeground = false
    
    func setState(isForeground: Bool) -> Void {
        inForeground = isForeground
    }
}

final class Notifications: ObservableObject {
    static let shared = Notifications()
    private var enabled = false
    private var notificationId: String?
    private var inBackground = false
    
    func handleAppState(_ phase: ScenePhase) {
        switch phase {
        case .background:
            inBackground = true
        case .active:
            inBackground = false
        default:
            break
        }
    }
    
    func handleNotificationPermission() -> Void {
        // Check if notifications are enabled
        // If enabled do nothing
        // If not enabled
        // if we previously asked, send them to settings app to turn on
        // otherwise show the initial notification prompt
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                self.enabled = true
//                let notificationCenter = NotificationCenter.default
//                notificationCenter.addObserver(self, selector: <#T##Selector#>, name: UIApplication.willResignActiveNotification, object: nil)
            } else if let error = error {
                print("[Notifications] - Error: \(error.localizedDescription)")
                self.enabled = false
            }
        }
    }
    
    /*
     - add listeners for when the app moves to the background and foreground
     - when app moves to background schedule a local notification
     - when app moves to foreground cancel the local notification
     */
    
    deinit {
        guard enabled else { return }
        // Remove app state listeners
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
//        notificationCenter.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Rest complete!"
        content.subtitle = "You're on set 1. Go!"
        content.sound = UNNotificationSound.defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
        let id = UUID().uuidString
        self.notificationId = id
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
