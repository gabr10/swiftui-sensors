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
    @State var dataDict: SensorData = SensorData(x: [], y: [], z: [], rx: [], ry: [], rz: [])
    @State var x:[Float] = []
    @State var y:[Float] = []
    @State var z:[Float] = []
    @State var rx:[Float] = []
    @State var ry:[Float] = []
    @State var rz:[Float] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Accelerometer Data")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Group {
                    Chart(Array(x.enumerated()), id:\.0){ index, magnitud in
                        LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                            .foregroundStyle(.secondary)
                        
                    }
                    .onReceive(timer, perform: updateData)
                    .chartYScale(domain: -3 ... Constants.magLimit)
                    .chartXAxis(.hidden)
                    .background(Color.secondary.opacity(0.2))
                    .clipped()
                    .cornerRadius(10)
                    
                    Spacer()
                }
                Group {
                    Chart(Array(y.enumerated()), id:\.0){ index, magnitud in
                        LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                        
                    }
                    .onReceive(timer, perform: updateData)
                    .chartYScale(domain: -3 ... Constants.magLimit)
                    .chartXAxis(.hidden)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                    Spacer()
                }
                Group {
                    Chart(Array(z.enumerated()), id:\.0){ index, magnitud in
                        LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                        
                    }
                    .onReceive(timer, perform: updateData)
                    .chartYScale(domain: -3 ... Constants.magLimit)
                    .chartXAxis(.hidden)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                    Spacer()
                }
                Group {
                    Chart(Array(rx.enumerated()), id:\.0){ index, magnitud in
                        LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                        
                    }
                    .onReceive(timer, perform: updateData)
                    .chartYScale(domain: -3 ... Constants.magLimit)
                    .chartXAxis(.hidden)

                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                    Spacer()
                }
                Group {
                    Chart(Array(ry.enumerated()), id:\.0){ index, magnitud in
                        LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                        
                    }
                    .onReceive(timer, perform: updateData)
                    .chartYScale(domain: -3 ... Constants.magLimit)
                    .chartXAxis(.hidden)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                    Spacer()
                }
                Group {
                    Chart(Array(rz.enumerated()), id:\.0){ index, magnitud in
                        LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitud))
                        
                    }
                    .onReceive(timer, perform: updateData)
                    .chartYScale(domain: -3 ... Constants.magLimit)
                    .chartXAxis(.hidden)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .font(.title2)
            .padding()
//            .background(Color.secondary.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
        }
            .onAppear(perform: onAppear)
            .onDisappear(perform: onDisappear)
        }
    
    // Start accelerometer updates when the view appears
        func onAppear() {
            accelerometerManager.startUpdates()
        }
        
        // Stop accelerometer updates when the view disappears
        func onDisappear() {
            accelerometerManager.stopUpdates()
        }
        func updateData(_: Date) {
            dataDict = accelerometerManager.arr
            
            x = dataDict.x.map {
                min($0, Constants.magLimit)
    
            }
            y = dataDict.y.map {
                min($0, Constants.magLimit)
    
            }
            z = dataDict.z.map {
                min($0, Constants.magLimit)
    
            }
            rx = dataDict.rx.map {
                min($0, Constants.magLimit)
    
            }
            ry = dataDict.ry.map {
                min($0, Constants.magLimit)
    
            }
            rz = dataDict.rz.map {
                min($0, Constants.magLimit)
    
            }
            
//          print(data)
        
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
