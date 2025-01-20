//
//  MotionKit.swift
//  MotionKit
//
//  Created by Haroon on 14/02/2015.
//  Launched under the Creative Commons License. You're free to use MotionKit.
//
//  The original Github repository is https://github.com/MHaroonBaig/MotionKit
//  The official blog post and documentation is https://medium.com/@PyBaig/motionkit-the-missing-ios-coremotion-wrapper-written-in-swift-99fcb83355d0
//

import Foundation
import CoreMotion

//_______________________________________________________________________________________________________________
// this helps retrieve values from the sensors.
@objc protocol MotionKitDelegate {
    @objc optional  func retrieveAccelerometerValues (x: Double, y:Double, z:Double, absoluteValue: Double)
    @objc optional  func retrieveGyroscopeValues     (x: Double, y:Double, z:Double, absoluteValue: Double)
    @objc optional  func retrieveDeviceMotionObject  (deviceMotion: CMDeviceMotion)
    @objc optional  func retrieveMagnetometerValues  (x: Double, y:Double, z:Double, absoluteValue: Double)
    
    @objc optional  func getAccelerationValFromDeviceMotion        (x: Double, y:Double, z:Double)
    @objc optional  func getGravityAccelerationValFromDeviceMotion (x: Double, y:Double, z:Double)
    @objc optional  func getRotationRateFromDeviceMotion           (x: Double, y:Double, z:Double)
    @objc optional  func getMagneticFieldFromDeviceMotion          (x: Double, y:Double, z:Double)
    @objc optional  func getAttitudeFromDeviceMotion               (attitude: CMAttitude)
}


@objc(MotionKit) public class MotionKit :NSObject{
    
    let manager = CMMotionManager()
    var delegate: MotionKitDelegate?
    
    /*
    *  init:void:
    *
    *  Discussion:
    *   Initialises the MotionKit class and throw a Log with a timestamp.
    */
    public override init(){
        super.init()
        print("MotionKit has been initialised successfully")
    }
    
    /*
    *  getAccelerometerValues:interval:values:
    *
    *  Discussion:
    *   Starts accelerometer updates, providing data to the given handler through the given queue.
    *   Note that when the updates are stopped, all operations in the
    *   given NSOperationQueue will be cancelled. You can access the retrieved values either by a
    *   Trailing Closure or through a Delgate.
    */
    public func getAccelerometerValues(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())?) {
        guard manager.isAccelerometerAvailable else {
            print("The Accelerometer is not available")
            return
        }
        
        manager.accelerometerUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startAccelerometerUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            
            values?(x, y, z)
            
            let absoluteVal = sqrt(x * x + y * y + z * z)
            self?.delegate?.retrieveAccelerometerValues?(x: x, y: y, z: z, absoluteValue: absoluteVal)
        }
    }
    
    /*
    *  getGyroValues:interval:values:
    *
    *  Discussion:
    *   Starts gyro updates, providing data to the given handler through the given queue.
    *   Note that when the updates are stopped, all operations in the
    *   given NSOperationQueue will be cancelled. You can access the retrieved values either by a
    *   Trailing Closure or through a Delegate.
    */
    public func getGyroValues(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())?) {
        guard manager.isGyroAvailable else {
            print("The Gyroscope is not available")
            return
        }
        
        manager.gyroUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startGyroUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let data = data else { return }
            
            let x = data.rotationRate.x
            let y = data.rotationRate.y
            let z = data.rotationRate.z
            
            values?(x, y, z)
            
            let absoluteVal = sqrt(x * x + y * y + z * z)
            self?.delegate?.retrieveGyroscopeValues?(x: x, y: y, z: z, absoluteValue: absoluteVal)
        }
    }
    
    /*
    *  getMagnetometerValues:interval:values:
    *
    *  Discussion:
    *   Starts magnetometer updates, providing data to the given handler through the given queue.
    *   You can access the retrieved values either by a Trailing Closure or through a Delegate.
    */
    @available(iOS, introduced: 5.0)
    public func getMagnetometerValues(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())?) {
        guard manager.isMagnetometerAvailable else {
            print("Magnetometer is not available")
            return
        }
        
        manager.magnetometerUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startMagnetometerUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let data = data else { return }
            
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            
            values?(x, y, z)
            
            let absoluteVal = sqrt(x * x + y * y + z * z)
            self?.delegate?.retrieveMagnetometerValues?(x: x, y: y, z: z, absoluteValue: absoluteVal)
        }
    }
    
    /*  MARK :- DEVICE MOTION APPROACH STARTS HERE  */
    
    /*
    *  getDeviceMotionValues:interval:values:
    *
    *  Discussion:
    *   Starts device motion updates, providing data to the given handler through the given queue.
    *   Uses the default reference frame for the device. Examine CMMotionManager's
    *   attitudeReferenceFrame to determine this. You can access the retrieved values either by a
    *   Trailing Closure or through a Delegate.
    */
    public func getDeviceMotionObject(interval: TimeInterval = 0.1, values: ((_ deviceMotion: CMDeviceMotion) -> ())?) {
        guard manager.isDeviceMotionAvailable else {
            print("Device Motion is not available")
            return
        }
        
        manager.deviceMotionUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let motionData = data else { return }
            
            values?(motionData)
            self?.delegate?.retrieveDeviceMotionObject?(deviceMotion: motionData)
        }
    }
    
    
    /*
    *   getAccelerationFromDeviceMotion:interval:values:
    *   You can retrieve the processed user accelaration data from the device motion from this method.
    */
    public func getAccelerationFromDeviceMotion(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())?) {
        guard manager.isDeviceMotionAvailable else {
            print("Device Motion is unavailable")
            return
        }
        
        manager.deviceMotionUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let motionData = data else { return }
            
            let x = motionData.userAcceleration.x
            let y = motionData.userAcceleration.y
            let z = motionData.userAcceleration.z
            
            values?(x, y, z)
            self?.delegate?.getAccelerationValFromDeviceMotion?(x: x, y: y, z: z)
        }
    }
    
    /*
    *   getGravityAccelerationFromDeviceMotion:interval:values:
    *   You can retrieve the processed gravitational accelaration data from the device motion from this
    *   method.
    */
    public func getGravityAccelerationFromDeviceMotion(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())?) {
        guard manager.isDeviceMotionAvailable else {
            print("Device Motion is not available")
            return
        }
        
        manager.deviceMotionUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let motionData = data else { return }
            
            let x = motionData.gravity.x
            let y = motionData.gravity.y
            let z = motionData.gravity.z
            
            values?(x, y, z)
            
            let absoluteVal = sqrt(x * x + y * y + z * z)
            self?.delegate?.getGravityAccelerationValFromDeviceMotion?(x: x, y: y, z: z)
        }
    }
    
    
    /*
    *   getAttitudeFromDeviceMotion:interval:values:
    *   You can retrieve the processed attitude data from the device motion from this
    *   method.
    */
    public func getAttitudeFromDeviceMotion(interval: TimeInterval = 0.1, values: ((_ attitude: CMAttitude) -> ())?) {
        guard manager.isDeviceMotionAvailable else {
            print("Device Motion is not available")
            return
        }
        
        manager.deviceMotionUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let motionData = data else { return }
            
            values?(motionData.attitude)
            self?.delegate?.getAttitudeFromDeviceMotion?(attitude: motionData.attitude)
        }
    }
    
    /*
    *   getRotationRateFromDeviceMotion:interval:values:
    *   You can retrieve the processed rotation data from the device motion from this
    *   method.
    */
    public func getRotationRateFromDeviceMotion(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double) -> ())?) {
        guard manager.isDeviceMotionAvailable else {
            print("Device Motion is not available")
            return
        }
        
        manager.deviceMotionUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let motionData = data else { return }
            
            let x = motionData.rotationRate.x
            let y = motionData.rotationRate.y
            let z = motionData.rotationRate.z
            
            values?(x, y, z)
            
            let absoluteVal = sqrt(x * x + y * y + z * z)
            self?.delegate?.getRotationRateFromDeviceMotion?(x: x, y: y, z: z)
        }
    }
    
    
    /*
    *   getMagneticFieldFromDeviceMotion:interval:values:
    *   You can retrieve the processed magnetic field data from the device motion from this
    *   method.
    */
    public func getMagneticFieldFromDeviceMotion(interval: TimeInterval = 0.1, values: ((_ x: Double, _ y: Double, _ z: Double, _ accuracy: Int32) -> ())?) {
        guard manager.isDeviceMotionAvailable else {
            print("Device Motion is not available")
            return
        }
        
        manager.deviceMotionUpdateInterval = interval
        let queue = OperationQueue()
        
        manager.startDeviceMotionUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let motionData = data else { return }
            
            let field = motionData.magneticField.field
            let accuracy = motionData.magneticField.accuracy.rawValue
            
            values?(field.x, field.y, field.z, accuracy)
            self?.delegate?.getMagneticFieldFromDeviceMotion?(x: field.x, y: field.y, z: field.z)
        }
    }
    
    /*  MARK :- DEVICE MOTION APPROACH ENDS HERE    */
    
    
    /*
    *   From the methods hereafter, the sensor values could be retrieved at
    *   a particular instant, whenever needed, through a trailing closure.
    */
    
    /*  MARK :- INSTANTANIOUS METHODS START HERE  */
    
    public func getAccelerationAtCurrentInstant(values: @escaping (_ x: Double, _ y: Double, _ z: Double) -> ()) {
        self.getAccelerationFromDeviceMotion(interval: 0.5) { (x, y, z) in
            values(x, y, z)
            self.stopDeviceMotionUpdates()
        }
    }
    
    public func getGravitationalAccelerationAtCurrentInstant(values: @escaping (_ x: Double, _ y: Double, _ z: Double) -> ()) {
        self.getGravityAccelerationFromDeviceMotion(interval: 0.5) { (x, y, z) in
            values(x, y, z)
            self.stopDeviceMotionUpdates()
        }
    }
    
    public func getAttitudeAtCurrentInstant(values: @escaping (_ attitude: CMAttitude) -> ()) {
        self.getAttitudeFromDeviceMotion(interval: 0.5) { (attitude) in
            values(attitude)
            self.stopDeviceMotionUpdates()
        }
    }
    
    public func getMageticFieldAtCurrentInstant(values: @escaping (_ x: Double, _ y: Double, _ z: Double) -> ()) {
        self.getMagneticFieldFromDeviceMotion(interval: 0.5) { (x, y, z, accuracy) in
            values(x, y, z)
            self.stopDeviceMotionUpdates()
        }
    }
    
    public func getGyroValuesAtCurrentInstant(values: @escaping (_ x: Double, _ y: Double, _ z: Double) -> ()) {
        self.getRotationRateFromDeviceMotion(interval: 0.5) { (x, y, z) in
            values(x, y, z)
            self.stopDeviceMotionUpdates()
        }
    }
    
    /*  MARK :- INSTANTANIOUS METHODS END HERE  */
    
    
    
    /*
    *  stopAccelerometerUpdates
    *
    *  Discussion:
    *   Stop accelerometer updates.
    */
    public func stopAccelerometerUpdates(){
        self.manager.stopAccelerometerUpdates()
        print("Accelaration Updates Status - Stopped")
    }
    
    /*
    *  stopGyroUpdates
    *
    *  Discussion:
    *   Stops gyro updates.
    */
    public func stopGyroUpdates(){
        self.manager.stopGyroUpdates()
        print("Gyroscope Updates Status - Stopped")
    }
    
    /*
    *  stopDeviceMotionUpdates
    *
    *  Discussion:
    *   Stops device motion updates.
    */
    public func stopDeviceMotionUpdates() {
        self.manager.stopDeviceMotionUpdates()
        print("Device Motion Updates Status - Stopped")
    }
    
    /*
    *  stopMagnetometerUpdates
    *
    *  Discussion:
    *   Stops magnetometer updates.
    */
    @available(iOS, introduced: 5.0)
    public func stopmagnetometerUpdates() {
        self.manager.stopMagnetometerUpdates()
        print("Magnetometer Updates Status - Stopped")
    }
    
}
