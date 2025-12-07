import Foundation
import Flutter
import CoreMotion

class AccelerometerStreamHandler: NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    private let motionManager = CMMotionManager()
    private var lastEmitTime: TimeInterval = 0
    private let throttleInterval: TimeInterval = 0.25 // 250ms = 4 Hz
    
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        
        guard motionManager.isAccelerometerAvailable else {
            return FlutterError(
                code: "NO_SENSOR",
                message: "Accelerometer not available",
                details: nil
            )
        }
        
        motionManager.accelerometerUpdateInterval = 0.01 // 100Hz raw data
        
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let self = self else { return }
            
            if let error = error {
                events(FlutterError(
                    code: "SENSOR_ERROR",
                    message: error.localizedDescription,
                    details: nil
                ))
                return
            }
            
            guard let data = data else { return }
            
            let currentTime = Date().timeIntervalSince1970
            
            
            if currentTime - self.lastEmitTime >= self.throttleInterval {
                self.lastEmitTime = currentTime
                
                let result: [String: Any] = [
                    "x": data.acceleration.x,
                    "y": data.acceleration.y,
                    "z": data.acceleration.z,
                    "timestamp": Int(currentTime * 1000)
                ]
                
                events(result)
            }
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        motionManager.stopAccelerometerUpdates()
        eventSink = nil
        return nil
    }
}
