//
//  ContentView.swift
//  tiempo-poc Watch App
//
//  Created by ivan koop on 2023-06-09.
//

import SwiftUI
import Charts


enum RepState {
    case active
    case completed
    case pending
}

struct WorkOutRep {
    enum RepState {
        case active
        case completed
        case pending
    }

    var state: RepState
    var color: Color

    func getColor() -> Color {
        switch state {
        case .active:
            return color
        case .completed:
            return .green
        case .pending:
            return .gray
        }
    }
}

struct ContentView: View {
    let gapAngle: Double = 4
    let gap = 0.04
    let rotationAngle: Angle = .degrees(225)

    @State var reps = [
            WorkOutRep(state: .active, color: .yellow),
            WorkOutRep(state: .pending, color: .yellow),
            WorkOutRep(state: .pending, color: .yellow),
            WorkOutRep(state: .pending, color: .yellow)
        ]

    @State var activeRepIndex = 0
    @State var elapsedSeconds = 0
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    ForEach(0..<reps.count) { index in
                        Circle()
                            .trim(from: CGFloat(index) / CGFloat(reps.count) + CGFloat(gap/2),
                                  to: CGFloat(index + 1) / CGFloat(reps.count) - CGFloat(gap/2))
                            .stroke(
                                reps[index].getColor(),
                                style: StrokeStyle(lineWidth: 5, lineCap: .round)
                            )
                            .rotationEffect(.degrees(360.0 / Double(reps.count) / 2))  // Adjust rotation to align gaps
                    }

                    ForEach(0..<reps.count) { index in
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 5, height: 5)
                            .offset(y: -75)
                            .rotationEffect(.degrees((Double(index) + 0.5) * (360.0 / Double(reps.count))))
                    }
                }
                .rotationEffect(rotationAngle)
                .frame(width: 150, height: 150)
                
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
#Preview {
    ContentView()
}
