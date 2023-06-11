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
        case rest
        case paused
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
        case .rest:
            return color
        case .paused:
            return .gray
        }
    }
    
    func getRestColor() -> Color {
        switch state {
        case .active:
            return .gray
        case .completed:
            return .gray
        case .pending:
            return .gray
        case .rest:
            // TODO: move these colors to config file
            return Color(red: 0xF2 / 255, green: 0xEB / 255, blue: 0xDF / 255, opacity: 1.0)
        case .paused:
            // TODO: move these colors to config file
            return Color(red: 0xF2 / 255, green: 0xEB / 255, blue: 0xDF / 255, opacity: 1.0)
        }
    }
}
