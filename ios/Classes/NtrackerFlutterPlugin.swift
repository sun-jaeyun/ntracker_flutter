import Flutter
import UIKit
import NTrackerSDKExt

public class NtrackerFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ntracker_flutter", binaryMessenger: registrar.messenger())
    let instance = NtrackerFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initialize":
      self.initialize(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let argMaps = call.arguments as? Dictionary<String, Any>,
      let siteId = argMaps["ios"],
      let debug = argMaps["debug"] as? Bool else {
      result(FlutterError(code: call.method, message: "Missing argument", details: nil))
      return
    }

    NTrackerExt.enableDebugLog(debug)
    NTrackerExt.configure(serviceID: siteId, phase: debug ? .debug : .Release)

    result(true)
  }
}
