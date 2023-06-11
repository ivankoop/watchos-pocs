//
//  StepsCircle.swift
//  tiempo-poc Watch App
//
//  Created by ivan koop on 2023-06-10.
//

import Foundation
import SwiftUI

struct StepsCircle: View {

  let gapAngle: Double = 4
  let gap: Double = 0.04
  var reps: [WorkOutRep]


  // Calculate rotationAngle based on the number of reps
  var rotationAngle: Angle {

    switch reps.count {
    case 2:
      return .degrees(180)
    case 3:
      return .degrees(210)
    case 4:
      return .degrees(225)
    case 5:
      return .degrees(235)
    case 6:
      return .degrees(240)
    case 7:
      return .degrees(245)
    case 8:
      return .degrees(247)
    case 9:
      return .degrees(250)
    case 10:
      return .degrees(252)
    default:
      return .degrees(250)
    }
  }

  // Calculate restItemPosModifier based on the number of reps
  var restItemPosModifier: Double {
      return (max((Double(reps.count) + 6) * 0.25, 0) )
  }

  var body: some View {

    ZStack {

      ForEach(0..<reps.count) { index in
        Circle()
          .trim(
            from: CGFloat(index) / CGFloat(reps.count) + CGFloat(gap / 2),
            to: CGFloat(index + 1) / CGFloat(reps.count) - CGFloat(gap / 2)
          )
          .stroke(
            reps[index].getColor(),
            style: StrokeStyle(lineWidth: 5, lineCap: .round)
          )
          .rotationEffect(.degrees(360.0 / Double(reps.count) / 2))
      }

      ForEach(0..<reps.count) { index in
        Circle()
          .fill(reps[index].getRestColor())
          .frame(width: 5, height: 5)
          .offset(y: -75)
          .rotationEffect(
            .degrees((Double(index) + restItemPosModifier) * (360.0 / Double(reps.count))))
      }
    }.rotationEffect(rotationAngle).frame(width: 150, height: 150)
  }
}

#Preview{
  StepsCircle(reps: [
    WorkOutRep(state: .rest, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    WorkOutRep(state: .pending, color: .yellow),
    
  ])
}
