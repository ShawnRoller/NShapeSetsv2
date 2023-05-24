# ``NShapeSets``

## Overview

NShape Sets built with SwiftUI (and a bit of UIKit)

## Topics

### TODO

- [ ] implement a timer class
    - [ ] tie it to the "rest" duration of a Workout
- [ ] animate the "active" ring so it pulses with every second that goes by
- [ ] consider moving the observable objects like countdownTimer to the appropriate view, rather than the workout
- [x] flesh out how nextSet, startRest, and endWorkout should function
- [x] Make the ContentView work
    - [x] The Sliders need to update the Workout value appropriately
    - [x] Start button should send to the ActiveWorkout content
    - [x] Start button title should change depending on whether the workout is started, and whether it's Rest mode or Active mode (Start, Rest, Skip)
    
### Timer

How it should work

- counts down and stops at 0
- publishes the current value
- has controls like start, pause, stop (resets back to original value and invalidates timer)
- accepts a start value
- runs in the background
- triggers a local notification when the timer hits 0


