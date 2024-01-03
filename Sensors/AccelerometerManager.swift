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
    var mx: [Float]
    var my: [Float]
    var mz: [Float]
}


class AccelerometerManager : ObservableObject {
    
    private let motionManager = CMMotionManager()
    @Published var arr: SensorData = SensorData.init(x: [], y: [], z: [], rx: [], ry: [], rz: [], mx: [], my: [], mz: [])
    @Published var dataDict: SensorData = SensorData(x: [], y: [], z: [], rx: [], ry: [], rz: [], mx: [], my: [], mz: [])

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

            // Process the accelerometer data or perform any desired actions
            print("Accelerometer data: x=\( acceleration.x), y=\( acceleration.y), z=\( acceleration.z)")
            if self.arr.x.count > 100 {
                self.arr.x.remove(at: 0)
                self.arr.y.remove(at: 0)
                self.arr.z.remove(at: 0)
            }
            self.arr.x.append(Float(acceleration.x))
            self.arr.y.append(Float(acceleration.y))
            self.arr.z.append(Float(acceleration.z))

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
            if self.arr.rx.count > 100 {
                self.arr.rx.remove(at: 0)
                self.arr.ry.remove(at: 0)
                self.arr.rz.remove(at: 0)
            }

            self.arr.rx.append(Float(rotationRate.x))
            self.arr.ry.append(Float(rotationRate.y))
            self.arr.rz.append(Float(rotationRate.z))
            
            // Process the gyroscope data or perform any desired actions
            print("Gyroscope data: x=\( rotationRate.x), y=\( rotationRate.y), z=\( rotationRate.z)")
        }
        
        guard motionManager.isMagnetometerAvailable else {
            print("Magnetometer is not available.")
            return
        }
        self.motionManager.magnetometerUpdateInterval = 0.1
        self.motionManager.startMagnetometerUpdates(to: .main) { data, error in
            
            if let error = error {
                print("Error receiving magneto data: \(error.localizedDescription)")
                return
            }
            guard let magnetoData = data else {
                print("No magnetoData available.")
                return
            }
            
            if self.arr.mx.count > 100 {
                self.arr.mx.remove(at: 0)
                self.arr.my.remove(at: 0)
                self.arr.mz.remove(at: 0)
            }
            self.arr.mx.append(Float(magnetoData.magneticField.x))
            self.arr.my.append(Float(magnetoData.magneticField.y))
            self.arr.mz.append(Float(magnetoData.magneticField.z))
            print("MagnetoData: x=\(Float(magnetoData.magneticField.x)), y=\(Float(magnetoData.magneticField.y)), z=\(Float(magnetoData.magneticField.z))")
        }
        
    }
    
    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
    }
    // Start accelerometer updates when the view appears
    func onAppear() {
        print("startUpdates...")
        self.startUpdates()
    }
    
    // Stop accelerometer updates when the view disappears
    func onDisappear() {
        print("stopUpdates...")
        self.stopUpdates()
    }
    func updateData(_: Date) {
        print("updateData for acc/gyro/mag...")
        dataDict = self.arr
    
    }
}



