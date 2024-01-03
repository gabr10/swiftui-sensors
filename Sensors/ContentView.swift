//
//  ContentView.swift
//  Sensors
//
//  Created by Gabrio Barbieri on 5/10/23.
//

import SwiftUI
import Combine
import Charts


struct ContentView: View {
    
//    let timer = Timer.publish(
//            every: Constants.updateInterval,
//            on: .main,
//            in: .common
//        ).autoconnect()
    
    @ObservedObject var accelerometerManager = AccelerometerManager()
    @State private var isShowingDetailView = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Accelerometer Data")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    VStack(alignment: .center, spacing: 5) {
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

                        Button(action: {isShowingDetailView.toggle()}, label: {
                            Text("Magnetometer Data")
                        })
                        if isShowingDetailView {
                            NavigationLink(
                                destination: MagnetoView(magnetoManager: accelerometerManager),
                                isActive: $isShowingDetailView
                            ) {
                                EmptyView()
                            }
                            .hidden()
                        }
                        
                    }
                    .font(.title2)
                    .padding()
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .onAppear(perform: accelerometerManager.onAppear)
                //            .onDisappear(perform: accelerometerManager.onDisappear)
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
