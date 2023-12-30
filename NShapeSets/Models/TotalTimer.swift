//
//  TotalTimer.swift
//  NShapeSets
//
//  Created by Shawn Roller on 5/12/23.
//

import SwiftUI
import Combine

class TotalTimer: ObservableObject {
    @Published var totalTime: Int = 0
    private var timer: AnyCancellable?
    private var timerBackgroundDate: Date?
    
    init() {
    #if os(iOS)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    #endif
    }
    
    @objc func appMovedToForeground() {
        // get the difference between the current time and the timerEndDate in seconds
        guard let timerBackgroundDate else { return }
        let differenceInSeconds = Calendar.current.dateComponents([.second], from: timerBackgroundDate, to: Date.now).second
        
        guard let differenceInSeconds else {
            // just continue the timer
            start()
            return
        }
        // Add the time that elapsed while in the background
        totalTime += differenceInSeconds
        start()
    }

    @objc func appMovedToBackground() {
        timer?.cancel()
        self.timerBackgroundDate = Date.now
    }
    
    func start() -> Void {
        timer = Timer.publish(every: 1, on: .main, in: .common)
                    .autoconnect()
                    .sink { [weak self] _ in
                        guard let self = self else { return }
                        self.totalTime += 1
                    }
    }
    
    func pause() -> Void {
        timer?.cancel()
    }
    
    func stop() -> Void {
        timer?.cancel()
        totalTime = 0
    }
    
    static var example = TotalTimer()
}
