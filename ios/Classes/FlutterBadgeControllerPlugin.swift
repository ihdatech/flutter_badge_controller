import Flutter
import UIKit

public class FlutterBadgeControllerPlugin: NSObject, FlutterPlugin {
  private static var badgeCount: Int = 0
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_badge_controller", binaryMessenger: registrar.messenger())
    let instance = FlutterBadgeControllerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setBadgeCount":
      if let args = call.arguments as? [String: Any],
        let count = args["count"] as? Int {
        FlutterBadgeControllerPlugin.badgeCount = count
        DispatchQueue.main.async {
          UIApplication.shared.applicationIconBadgeNumber = count
        }
      }
      result(nil)

    case "clearBadge":
      FlutterBadgeControllerPlugin.badgeCount = 0
      DispatchQueue.main.async {
        UIApplication.shared.applicationIconBadgeNumber = 0
      }
      result(nil)

    case "getBadgeCount":
      result(FlutterBadgeControllerPlugin.badgeCount)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
