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
    
    init(initialTime: Int, onCountdownComplete: @escaping () -> Void) {
        self.initialTime = initialTime
        self.remainingTime = initialTime
        self.onCountdownComplete = onCountdownComplete
    }
    
    func start() -> Void {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
                    .autoconnect()
                    .sink { [weak self] _ in
                        guard let self = self else { return }
                        if self.remainingTime > 0 {
                            self.remainingTime -= 1
                        } else {
                            self.timer?.cancel()
                            self.onCountdownComplete()
//                            self.triggerNotification()
                        }
                    }
    }
    
    func pause() -> Void {
        timer?.cancel()
    }
    
    func stop() -> Void {
        timer?.cancel()
        remainingTime = initialTime
    }
    
    static var example = CountdownTimer(initialTime: 30, onCountdownComplete: {})
}
