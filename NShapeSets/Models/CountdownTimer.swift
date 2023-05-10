//
//  Timer.swift
//  NShapeSets
//
//  Created by Shawn Roller on 5/9/23.
//

import SwiftUI
import Combine

enum TimerState {
    case Stopped
    case Active
}

class CountdownTimer: ObservableObject {
    @Published var remainingTime: Int
    private var initialTime: Int
    private var timer: AnyCancellable?
    
    init(initialTime: Int) {
        self.initialTime = initialTime
        self.remainingTime = initialTime
    }
    
    func start() -> Void {
        timer = Timer.publish(every: 1, on: .main, in: .common)
                    .autoconnect()
                    .sink { [weak self] _ in
                        guard let self = self else { return }
                        if self.remainingTime > 0 {
                            self.remainingTime -= 1
                        } else {
                            self.timer?.cancel()
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
    
    static var example = CountdownTimer(initialTime: 30)
}
