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
  ]

  @State var activeRepIndex = 0
  @State var elapsedSeconds = 0
  @State var heartRate: Int = 0

  var body: some View {
    VStack {
      ZStack {
        ProgressCircle(progress: 0.8)
        StepsCircle(reps: reps)
          
          VStack {
              Text("3 of 4").foregroundColor(.yellow)
              Text("\(elapsedSeconds / 60):\(elapsedSeconds % 60, specifier: "%02d")")
                .font(.largeTitle)
                .foregroundColor(.white)
              HStack {
                  // TODO: improve size and spacing
                  Image(systemName: "heart.fill")
                              .foregroundColor(.white)
                              .font(.body)
                  Text("\(heartRate)")
                  Image(systemName: "arrow.down")
                              .foregroundColor(.white)
                              .font(.body)
                  
              }
          }
       
      }

    }.onAppear {
        startTimer()
    }
  }

    func startTimer() {
        let healthStore = HKHealthStore()
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        // Request permission to read heart rate data
        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { success, error in
            if success {
                let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
                    if let samples = samplesOrNil as? [HKQuantitySample] {
                        // Process the new heart rate samples...
                        DispatchQueue.main.async {
                            self.heartRate = Int(samples.last?.quantity.doubleValue(for: HKUnit(from: "count/min")) ?? 0)
                        }
                    }
                }
                
                // Fetch new data as it becomes available
                query.updateHandler = { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
                    if let samples = samplesOrNil as? [HKQuantitySample] {
                        // Process the new heart rate samples...
                        DispatchQueue.main.async {
                            self.heartRate = Int(samples.last?.quantity.doubleValue(for: HKUnit(from: "count/min")) ?? 0)
                        }
                    }
                }
                
                // Execute the query
                healthStore.execute(query)
            } else if let error = error {
                
                print("Failed to request heart rate data: \(error)")
            }
        }
    }
}
#Preview{
  ContentView()
}
