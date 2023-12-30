//
//  Timer.swift
//  NShapeSets
//
//  Created by Shawn Roller on 5/9/23.
//

import SwiftUI
import Combine

class CountdownTimer: ObservableObject {
    @Published var remainingTime: Int
    private var initialTime: Int
    private var onCountdownComplete: () -> Void
    private var timer: AnyCancellable?
    private var timerEndDate: Date?
    
    init(initialTime: Int, onCountdownComplete: @escaping () -> Void) {
        self.initialTime = initialTime
        self.remainingTime = initialTime
        self.onCountdownComplete = onCountdownComplete
        
        #if os(iOS)
            NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        #endif
    }
    
    @objc func appMovedToForeground() {
        // get the difference between the current time and the timerEndDate in seconds
        guard let timerEndDate, let timer else { return }
        let differenceInSeconds = Calendar.current.dateComponents([.second], from: Date(), to: timerEndDate).second
        
        guard let differenceInSeconds, differenceInSeconds > 0 else {
            onCountdownComplete()
            return
        }
        remainingTime = differenceInSeconds
        start()
    }

    @objc func appMovedToBackground() {
        guard remainingTime > 0 else { return }
        timer?.cancel()
        timer = nil
        self.timerEndDate = Date().addingTimeInterval(TimeInterval(remainingTime))
    }
    
    func start() -> Void {
        timer?.cancel()
        timer = nil
        timer = Timer.publish(every: 1, on: .main, in: .common)
                    .autoconnect()
                    .sink { [weak self] _ in
                        guard let self = self else { return }
                        if self.remainingTime > 0 {
                            self.remainingTime -= 1
                        } else {
                            self.timer?.cancel()
                            self.onCountdownComplete()
                        }
                    }
    }
    
    func pause() -> Void {
        timer?.cancel()
        timer = nil
    }
    
    func stop() -> Void {
        timer?.cancel()
        timer = nil
        remainingTime = initialTime
    }
    
    static var example = CountdownTimer(initialTime: 30, onCountdownComplete: {})
}
