//
//  SensorGraphView.swift
//  Sensors
//
//  Created by Gabrio Barbieri on 5/11/23.
//

import Foundation
import SwiftUI
import Charts

struct SensorChart: View {
    var accelerometerManager = AccelerometerManager()
    var arr: [Float] = []
    let timer = Timer.publish(
            every: Constants.updateInterval,
            on: .main,
            in: .common
        ).autoconnect()
    var body: some View {
        Chart(Array(arr.enumerated()), id:\.0){ index, magnitud in
            LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                .foregroundStyle(.secondary)
            
        }
        .onReceive(timer, perform: accelerometerManager.updateData)
        .chartYScale(domain: -3 ... Constants.magLimit)
        .chartXAxis(.hidden)
        .background(Color.secondary.opacity(0.2))
        .clipped()
        .cornerRadius(10)
        
        Spacer()
    }
}
