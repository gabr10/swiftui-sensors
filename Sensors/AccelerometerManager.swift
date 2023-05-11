//
//  SensorFeeder.swift
//  Sensors
//
//  Created by Gabrio Barbieri on 5/10/23.
//

import Foundation
import CoreMotion
import Combine

struct SensorData {
    var x: [Float]
    var y: [Float]
    var z: [Float]
    var rx: [Float]
    var ry: [Float]
    var rz: [Float]
}

class AccelerometerManager : ObservableObject {
    
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    @Published var z = 0.0
    @Published var rx = 0.0
    @Published var ry = 0.0
    @Published var rz = 0.0
    @Published var arr: SensorData = SensorData.init(x: [], y: [], z: [], rx: [], ry: [], rz: [])
    @Published var dataDict: SensorData = SensorData(x: [], y: [], z: [], rx: [], ry: [], rz: [])

    func startUpdates() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer is not available.")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1 // Update interval in seconds
        
        motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
            if let error = error {
                print("Error receiving accelerometer data: \(error.localizedDescription)")
                return
            }
            
            guard let accelerometerData = data else {
                print("No accelerometer data available.")
                return
            }
            
            // Access accelerometer data
            let acceleration = accelerometerData.acceleration
            self.x = acceleration.x
            self.y = acceleration.y
            self.z = acceleration.z
            
            // Process the accelerometer data or perform any desired actions
            print("Accelerometer data: x=\( self.x), y=\( self.y), z=\( self.z)")
            
            self.arr.x.append(Float(self.x))
            self.arr.y.append(Float(self.y))
            self.arr.z.append(Float(self.z))

//            print(self.xa)
        }
        guard motionManager.isGyroAvailable else {
                    print("Gyroscope is not available.")
                    return
                }
                
                motionManager.gyroUpdateInterval = 0.1 // Update interval in seconds
                
                motionManager.startGyroUpdates(to: .main) { (data, error) in
                    if let error = error {
                        print("Error receiving gyroscope data: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let gyroData = data else {
                        print("No gyroscope data available.")
                        return
                    }
                    
                    // Access gyroscope data
                    let rotationRate = gyroData.rotationRate
                    self.rx = rotationRate.x
                    self.ry = rotationRate.y
                    self.rz = rotationRate.z
                    self.arr.rx.append(Float(self.x))
                    self.arr.ry.append(Float(self.y))
                    self.arr.rz.append(Float(self.z))
                    // Process the gyroscope data or perform any desired actions
                    print("Gyroscope data: x=\( self.x), y=\( self.y), z=\( self.z)")
                }
    }
    
    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
    // Start accelerometer updates when the view appears
    func onAppear() {
        self.startUpdates()
    }
    
    // Stop accelerometer updates when the view disappears
    func onDisappear() {
        self.stopUpdates()
    }
    func updateData(_: Date) {
        dataDict = self.arr
    
    }
}
