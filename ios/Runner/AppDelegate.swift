import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // Siri Stuff
    var controller: FlutterViewController!
    var deviceChannel:FlutterMethodChannel!
  override func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Siri Stuff
      controller = window?.rootViewController as? FlutterViewController
      deviceChannel = FlutterMethodChannel(name: "rv.interview.sandbox/device", binaryMessenger: controller.binaryMessenger)
      
      deviceChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch (call.method) {
            case "getDeviceName":
                getDeviceName(result: result)
                break
            case "addSiriShortcut":
              addSiriShortcut(result: result, controller: self.controller);
                break;
            default:
                result(FlutterMethodNotImplemented)
          }
      });

      // Standard FLutter Plugin Registrant stuff
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        if userActivity.activityType == SiriShortcutActivityType, let parameters = userActivity.userInfo as? [String: String] {
            print("yo \(parameters.count)")
            if let page = userActivity.userInfo?["page"] as? String {
                deviceChannel.invokeMethod("navigate", arguments: page)
               
            }
            //try? BoardDeeplinkAction(parameters: parameters, context: persistentContainer.viewContext).execute()
            return true
        }
        return false
    }
}

private func navigatePage(result: FlutterResult,  page:String) {
   
     result(page)
}

private func getDeviceName(result: FlutterResult) {
    // Important: From iOS 16+, Access to device name is not allowed by default and requires
    // getting special entitlement
    // More info: https://developer.apple.com/documentation/uikit/uidevice/1620015-name
    let deviceName = UIDevice.current.name
     result(deviceName)
}

private func addSiriShortcut(result: @escaping FlutterResult, controller: FlutterViewController) {
    AddSiriShortcut(controller: controller);
    result("It is wednesday my dudes")
}
