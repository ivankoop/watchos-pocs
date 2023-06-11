//
//  ProgressCircle.swift
//  tiempo-poc Watch App
//
//  Created by ivan koop on 2023-06-11.
//

import Foundation
import SwiftUI

struct ProgressCircle: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(red: 0xF2 / 255, green: 0xEB / 255, blue: 0xDF / 255, opacity: 1.0),
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)).frame(width: 170, height: 170)
        }
    }
}

#Preview{
    ProgressCircle(progress: 1)
}

