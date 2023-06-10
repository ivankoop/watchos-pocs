//
//  ContentView.swift
//  tiempo-poc Watch App
//
//  Created by ivan koop on 2023-06-09.
//

import SwiftUI
import Charts


struct ContentView: View {

    let gapAngle: Double = 4
    let totalReps = 4
    let completedReps = 2
    let gap = 0.04
    let rotationAngle: Angle = .degrees(45)
    var body: some View {
            VStack {
                ZStack {
                    ForEach(0..<totalReps) { index in
                        Circle()
                            .trim(from: CGFloat(index) / CGFloat(totalReps) + gap/2,
                                  to: CGFloat(index + 1) / CGFloat(totalReps) - gap/2)
                            .stroke(
                                index < completedReps ? Color.green : Color.gray,
                                style: StrokeStyle(lineWidth: 5, lineCap: .round)
                            )
                            .rotationEffect(.degrees(360.0 / Double(totalReps) / 2))  // Adjust rotation to align gaps
                    }
                    
                    ForEach(0..<totalReps) { index in
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 5, height: 5)
                            .offset(y: -75)
                            .rotationEffect(.degrees((Double(index) + 0.5) * (360.0 / Double(totalReps))))
                    }
                }
                .rotationEffect(rotationAngle)
                .frame(width: 150, height: 150)
            }
        }
    
}

#Preview {
    ContentView()
}
