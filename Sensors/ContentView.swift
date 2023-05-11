//
//  ContentView.swift
//  Sensors
//
//  Created by Gabrio Barbieri on 5/10/23.
//

import SwiftUI
import Combine
import Charts

enum Constants {
    static let lineAmount = 40
    static let magLimit: Float = 3
    static let updateInterval = 0.03
}
struct ContentView: View {
    
    let timer = Timer.publish(
            every: Constants.updateInterval,
            on: .main,
            in: .common
        ).autoconnect()
    
    @ObservedObject var accelerometerManager = AccelerometerManager()

    var body: some View {
        VStack(spacing: 16) {
            Text("Accelerometer Data")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                SensorChart(accelerometerManager: accelerometerManager, arr: accelerometerManager.dataDict.x)
                SensorChart(accelerometerManager: accelerometerManager, arr: accelerometerManager.dataDict.y)
                SensorChart(accelerometerManager: accelerometerManager, arr: accelerometerManager.dataDict.z)
                
                Text("Gyroscope Data")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                SensorChart(accelerometerManager: accelerometerManager, arr: accelerometerManager.dataDict.rx)
                SensorChart(accelerometerManager: accelerometerManager, arr: accelerometerManager.dataDict.ry)
                SensorChart(accelerometerManager: accelerometerManager, arr: accelerometerManager.dataDict.rz)
            }
            .font(.title2)
            .padding()
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .onAppear(perform: accelerometerManager.onAppear)
        .onDisappear(perform: accelerometerManager.onDisappear)
        }
    
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
