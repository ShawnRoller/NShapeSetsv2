//
//  ActiveWorkoutTimerLiveActivity.swift
//  ActiveWorkoutTimer
//
//  Created by Shawn Roller on 11/6/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ActiveWorkoutTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActiveWorkoutTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("\(context.attributes.name) Set: \(context.state.currentSet) Rest: \(context.state.remainingRest)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
//                    Text("Bottom \(context.state.remainingRest)")
                    Group {
                        if context.state.state == .Rest {
                            Text(timerInterval: Date.now...context.state.restEndDate, countsDown: true)
                        } else {
                            Text("GOGOGO1")
                        }
                    }
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
//                Text("T \(context.state.remainingRest)")
                Group {
                    if context.state.state == .Rest {
                        Text(timerInterval: Date.now...context.state.restEndDate, countsDown: true)
                    } else {
                        Text("GOGOGO2")
                    }
                }
            } minimal: {
//                Text("\(context.state.remainingRest)")
                Group {
                    if context.state.state == .Rest {
                        Text(timerInterval: Date.now...context.state.restEndDate, countsDown: true)
                    } else {
                        Text("GOGOGO3")
                    }
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ActiveWorkoutTimerAttributes {
    fileprivate static var preview: ActiveWorkoutTimerAttributes {
        ActiveWorkoutTimerAttributes(sets: 23)
    }
}

extension ActiveWorkoutTimerAttributes.ContentState {
    fileprivate static var smiley: ActiveWorkoutTimerAttributes.ContentState {
        ActiveWorkoutTimerAttributes.ContentState(sets: 9, currentSet: 3, remainingRest: 30, state: .Active)
     }
     
     fileprivate static var starEyes: ActiveWorkoutTimerAttributes.ContentState {
         ActiveWorkoutTimerAttributes.ContentState(sets: 12, currentSet: 3, remainingRest: 29, state: .Active)
     }
}

#Preview("Live activity", as: .content, using: ActiveWorkoutTimerAttributes.preview) {
   ActiveWorkoutTimerLiveActivity()
} contentStates: {
    ActiveWorkoutTimerAttributes.ContentState.smiley
    ActiveWorkoutTimerAttributes.ContentState.starEyes
}

#Preview("Dynamic Island", as: .dynamicIsland(.compact), using: ActiveWorkoutTimerAttributes.preview) {
   ActiveWorkoutTimerLiveActivity()
} contentStates: {
    ActiveWorkoutTimerAttributes.ContentState.smiley
    ActiveWorkoutTimerAttributes.ContentState.starEyes
}

#Preview("Dynamic Island - Expanded", as: .dynamicIsland(.expanded), using: ActiveWorkoutTimerAttributes.preview) {
   ActiveWorkoutTimerLiveActivity()
} contentStates: {
    ActiveWorkoutTimerAttributes.ContentState.smiley
    ActiveWorkoutTimerAttributes.ContentState.starEyes
}

#Preview("Dynamic Island - Minimal", as: .dynamicIsland(.minimal), using: ActiveWorkoutTimerAttributes.preview) {
   ActiveWorkoutTimerLiveActivity()
} contentStates: {
    ActiveWorkoutTimerAttributes.ContentState.smiley
    ActiveWorkoutTimerAttributes.ContentState.starEyes
}
