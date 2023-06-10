//
//  ContentView.swift
//  tiempo-poc Watch App
//
//  Created by ivan koop on 2023-06-09.
//

import Charts
import HealthKit
import SwiftUI
import WorkoutKit

struct ContentView: View {
  let gapAngle: Double = 4
  let gap = 0.04
  let rotationAngle: Angle = .degrees(225)

  @State var reps = [
    WorkOutRep(state: .active, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    
  ]

  @State var activeRepIndex = 0
  @State var elapsedSeconds = 0

  var body: some View {
    VStack {
      ZStack {
        StepsCircle(reps: reps)

        Text("\(elapsedSeconds / 60):\(elapsedSeconds % 60, specifier: "%02d")")
          .font(.largeTitle)
          .foregroundColor(.white)
      }

    }.onAppear {
        startTimer()
    }
  }

  func startTimer() {
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
      self.elapsedSeconds += 1

      if self.elapsedSeconds % 5 == 0 {
        // Mark the current rep as active and the previous rep as completed
        if activeRepIndex < reps.count {
          if activeRepIndex > 0 {
            reps[activeRepIndex - 1].state = .completed
          }
          reps[activeRepIndex].state = .active
          activeRepIndex += 1

          // If all reps are now active or completed, stop the timer
          if activeRepIndex == reps.count {
            timer.invalidate()
          }
        }
      }
    }
  }
}
#Preview{
  ContentView()
}
