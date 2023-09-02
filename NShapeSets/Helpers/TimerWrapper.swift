//
//  TimerWrapper.swift
//  NShapeSets
//
//  Created by Shawn Roller on 7/18/23.
//

import Foundation
import UserNotifications

class TimerWrapper: ObservableObject {
    var timer: Timer?
    var rest: Int = 0
    var rounds: Int = 0
    @Published var remainingRest = 0
    @Published var currentRound = 1
    var startDate: Date?
    var isActive: Bool {
        return timer?.isValid ?? false
    }
    var nextSetString: String {
        let nextSet = self.currentRound + 1
        let finalString = nextSet == self.rounds ? "Last Set" : "\(nextSet) of \(self.rounds)"
        return finalString
    }
    var remainingRounds: Int {
        return self.rounds - self.currentRound
    }
    
    var onRestComplete: () -> Void?
    var onRestTimeChange: () -> Void?
    
    // Track total active time
    var totalTimer: Timer?
    @Published var totalTime = 0
    var totalStartDate: Date?
    
    // Notifications
    var authorizedNotifications = false
    var notificationID: String? = nil
    
    init(rest: Int, rounds: Int, currentRound: Int, authorizedNotifications: Bool, _ onRestComplete: @escaping () -> Void?, onRestTimeChange: @escaping () -> Void?) {
        self.rest = rest
        self.rounds = rounds
        self.remainingRest = rest
        self.currentRound = currentRound
        self.authorizedNotifications = authorizedNotifications
        self.onRestComplete = onRestComplete
        self.onRestTimeChange = onRestTimeChange
    }
    
    deinit {
//        #if os(iOS)
//            if self.authorizedNotifications {
//                    let notificationCenter = NotificationCenter.default
//                    notificationCenter.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
//                    notificationCenter.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
//            }
//        #endif
    }
    
    func start() {
        self.setupTimer()
        self.startDate = Date()
        
//        #if os(iOS)
//            // Listen for a notification to determine if the app enters the background so we can invalidate the timer and setup a local notification
//            self.addNotificationListener()
//        #endif
    }
    
    func addNotificationListener() {
//        #if os(iOS)
//            if self.authorizedNotifications {
//                let notificationCenter = NotificationCenter.default
//                notificationCenter.addObserver(self, selector: #selector(movedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
//                notificationCenter.addObserver(self, selector: #selector(movedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
//            }
//        #endif
    }
    
    @objc func movedToBackground() {
        if self.isActive {
            print("moved to background - setup a local notification!")
            self.timer?.invalidate()
            self.timer = nil
            self.setupLocalNotification()
        }
    }
    
    @objc func movedToForeground() {
        if let id = self.notificationID {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
            self.setupTimer()
        }
    }
    
    func setupLocalNotification() {
//        #if os(iOS)
//            let content = UNMutableNotificationContent()
//            content.title = "Rest complete!"
//            content.subtitle = "You're on set \(currentRound + 1). Go!"
//            content.sound = UNNotificationSound.defaultCritical
//            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.remainingRest), repeats: false)
//            self.notificationID = UUID().uuidString
//            let request = UNNotificationRequest(identifier: self.notificationID ?? UUID().uuidString, content: content, trigger: trigger)
//            
//            UNUserNotificationCenter.current().add(request)
//        #endif
    }
    
    func setupTimer() {
        self.timer?.invalidate()
        self.timer = nil
        let newTimer = Timer(timeInterval: 1.0,
                        target: self,
                        selector: #selector(countdown),
                        userInfo: nil,
                        repeats: true)
        RunLoop.current.add(newTimer, forMode: .default)
        newTimer.tolerance = 0.1
        self.timer = newTimer
    }
    
    @objc func countdown() {
        DispatchQueue.main.async {
            self.onRestTimeChange()
            self.remainingRest = self.rest - Int(Date().timeIntervalSince(self.startDate ?? Date()))
            if self.remainingRest < 0 {
                self.onRestComplete()
            }
        }
    }
    
    func restComplete() {
        if currentRound + 1 <= rounds {
            timer?.invalidate()
            currentRound += 1
            remainingRest = rest
        }
        else {
            reset()
        }
    }
    
    func reset() {
        self.timer?.invalidate()
        self.currentRound = 1
        self.remainingRest = rest
        
        self.totalTimer?.invalidate()
        self.totalTime = 0
    }
    
    func pause() {
        self.timer?.invalidate()
        self.totalTimer?.invalidate()
    }
    
    @objc func incrementTotalTime() {
        self.totalTime = Int(Date().timeIntervalSince(self.totalStartDate ?? Date()))
    }
    
    func startTimeTracking() {
        if self.totalTime == 0 {
            self.totalTimer?.invalidate()
            self.totalTimer = nil
            let newTimer = Timer(timeInterval: 1.0,
                            target: self,
                            selector: #selector(incrementTotalTime),
                            userInfo: nil,
                            repeats: true)
            RunLoop.current.add(newTimer, forMode: .default)
            newTimer.tolerance = 0.1
            self.totalTimer = newTimer
            self.totalStartDate = Date()
        }
    }
    
    func stopTimeTracking() {
        self.totalTimer?.invalidate()
    }
    
    static let example = TimerWrapper(rest: 3, rounds: 4, currentRound: 1, authorizedNotifications: false) { () -> Void? in
        return
    } onRestTimeChange: { () -> Void? in
        return
    }

}

