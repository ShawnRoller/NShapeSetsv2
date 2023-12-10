//
//  ActivityManager.swift
//  NShapeSets
//
//  Created by Shawn Roller on 11/16/23.
//

import ActivityKit
import Combine
import Foundation

final class ActivityManager: ObservableObject {
    @MainActor @Published private(set) var activityID: String?
    @MainActor @Published private(set) var activityToken: String?
    
    static let shared = ActivityManager()
    
    func start(sets: Int, currentSet: Int, rest: Int, state: WorkoutState) async {
        await endActivity()
        await startNewLiveActivity(sets: sets, currentSet: currentSet, rest: rest, state: state)
    }
    
    private func startNewLiveActivity(sets: Int, currentSet: Int, rest: Int, state: WorkoutState) async {
        let attributes = ActiveWorkoutTimerAttributes(sets: sets)
        
        let endDate = Date.now.addingTimeInterval(TimeInterval(rest))
        let initialContentState = ActivityContent(state: ActiveWorkoutTimerAttributes.ContentState(sets: sets, currentSet: 1, remainingRest: rest, state: state), staleDate: nil)
        
        let activity = try? Activity.request(attributes: attributes, content: initialContentState)
        
        guard let activity = activity else {
            return
        }
        await MainActor.run { activityID = activity.id }
        
        for await data in activity.pushTokenUpdates {
            let token = data.map {String(format: "%02x", $0)}.joined()
            print("Activity token: \(token)")
            await MainActor.run { activityToken = token }
            // HERE SEND THE TOKEN TO THE SERVER
        }
    }
    
    func updateActivity(sets: Int, currentSet: Int, rest: Int, state: WorkoutState) async {
        guard let activityID = await activityID,
              let runningActivity = Activity<ActiveWorkoutTimerAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
        }
        let newRandomContentState = ActiveWorkoutTimerAttributes.ContentState(sets: sets, currentSet: currentSet, remainingRest: rest, state: state)
        await runningActivity.update(using: newRandomContentState)
    }
    
    func endActivity() async {
        guard let activityID = await activityID,
              let runningActivity = Activity<ActiveWorkoutTimerAttributes>.activities.first(where: { $0.id == activityID }) else {
            return
        }
        
        let initialContentState = ActiveWorkoutTimerAttributes.ContentState(sets: 0, currentSet: 0, remainingRest: 0, state: .Active)

        await runningActivity.end(
            ActivityContent(state: initialContentState, staleDate: Date.distantFuture),
            dismissalPolicy: .immediate
        )
        
        await MainActor.run {
            self.activityID = nil
            self.activityToken = nil
        }
    }
    
    func cancelAllRunningActivities() async {
        for activity in Activity<ActiveWorkoutTimerAttributes>.activities {
            let initialContentState = ActiveWorkoutTimerAttributes.ContentState(sets: 0, currentSet: 0, remainingRest: 0, state: .Active)
            
            await activity.end(
                ActivityContent(state: initialContentState, staleDate: Date()),
                dismissalPolicy: .immediate
            )
        }
        
        await MainActor.run {
            activityID = nil
            activityToken = nil
        }
    }
    
}
