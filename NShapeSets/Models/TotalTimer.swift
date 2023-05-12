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
