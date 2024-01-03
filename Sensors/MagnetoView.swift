//
//  ContentView.swift
//  Sensors
//
//  Created by Gabrio Barbieri on 5/10/23.
//

import SwiftUI
import Combine
import Charts


struct MagnetoView: View {
    
//    let timer = Timer.publish(
//            every: Constants.updateInterval,
//            on: .main,
//            in: .common
//        ).autoconnect()
    
    @StateObject var magnetoManager : AccelerometerManager  = AccelerometerManager()
//    @ObservedObject var dDict:
    var body: some View {
        VStack(spacing: 16) {
            Text("Magnetometer Data")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                SensorChart(accelerometerManager: magnetoManager, arr: magnetoManager.dataDict.mx, lowLimit: -350, highLimit: 350)
                SensorChart(accelerometerManager: magnetoManager, arr: magnetoManager.dataDict.my, lowLimit: -350, highLimit: 350)
                SensorChart(accelerometerManager: magnetoManager, arr: magnetoManager.dataDict.mz, lowLimit: -350, highLimit: 350)
                
            }
            .font(.title2)
            .padding()
            .cornerRadius(10)
            .padding(.horizontal)
        }
//        .onAppear(perform: magnetoManager!.onAppear)
//        .onDisappear(perform: magnetoManager!.onDisappear)
        }
    
        
}

struct MagnetoView_Previews: PreviewProvider {
    static var previews: some View {
        MagnetoView()
    }
}
