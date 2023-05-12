//
//  MagnetometerManager.swift
//  Sensors
//
//  Created by Gabrio Barbieri on 5/11/23.
//

import Foundation
import CoreMotion
import Combine

struct MagnetoData {
    var x: [Float]
    var y: [Float]
    var z: [Float]
}

class MagnetometerManager : ObservableObject{
    let manager = CMMotionManager()
    @Published var arr: MagnetoData = MagnetoData.init(x: [], y: [], z: [])
    
    
    func startUpdates() {
        guard manager.isMagnetometerAvailable else {
            print("Magnetometer is not available.")
            return
        }
        self.manager.startMagnetometerUpdates(to: .main) { data, error in
            self.manager.magnetometerUpdateInterval = 0.1
            print("MagnetoData: x=\( self.manager.magnetometerData?.magneticField.x ?? 0.0), y=\( self.manager.magnetometerData?.magneticField.y ?? 0.0), z=\( self.manager.magnetometerData?.magneticField.z ?? 0.0)")
            
            self.arr.x.append(Float(self.manager.magnetometerData?.magneticField.x ?? 0.0))
            self.arr.y.append(Float(self.manager.magnetometerData?.magneticField.y ?? 0.0))
            self.arr.z.append(Float(self.manager.magnetometerData?.magneticField.z ?? 0.0))
        }
        
    }

}
