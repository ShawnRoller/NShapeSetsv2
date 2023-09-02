//
//  WorkoutSessionContext.swift
//  NShapeSets-watch Watch App
//
//  Created by Shawn Roller on 7/18/23.
//

import Foundation
import HealthKit

class WorkoutSessionContext {
    
    let configuration: HKWorkoutConfiguration
    let healthStore: HKHealthStore
    
    init(healthStore: HKHealthStore, configuration: HKWorkoutConfiguration) {
        self.healthStore = healthStore
        self.configuration = configuration
    }
    
}
