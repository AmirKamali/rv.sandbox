import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      // Siri Stuff
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let deviceChannel = FlutterMethodChannel(name: "rv.interview.sandbox/device", binaryMessenger: controller.binaryMessenger)
      
      deviceChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch (call.method) {
            case "getDeviceName":
                getDeviceName(result: result)
                break
            case "addSiriShortcut":
                addSiriShortcut(result: result, controller: controller);
                break;
            default:
                result(FlutterMethodNotImplemented)
          }
      });

      // Standard FLutter Plugin Registrant stuff
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private func getDeviceName(result: FlutterResult) {
    let device = UIDevice.current
    result(device.name)
}

private func addSiriShortcut(result: @escaping FlutterResult, controller: FlutterViewController) {
    AddSiriShortcut(controller: controller);
    result("It is wednesday my dudes")
}
