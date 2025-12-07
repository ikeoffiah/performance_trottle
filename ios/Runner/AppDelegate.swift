import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller = window?.rootViewController as! FlutterViewController
      let accelerometerChannel = FlutterEventChannel(
          name: "com.bmoni/accelerometer",
          binaryMessenger: controller.binaryMessenger
      )
      accelerometerChannel.setStreamHandler(AccelerometerStreamHandler())
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
