//
//  WorkoutRep.swift
//  tiempo-poc Watch App
//
//  Created by ivan koop on 2023-06-10.
//

import Foundation
import SwiftUI

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
