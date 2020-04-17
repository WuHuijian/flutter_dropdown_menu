import Flutter
import UIKit

public class SwiftFlutterDropdownMenuPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_dropdown_menu", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterDropdownMenuPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
