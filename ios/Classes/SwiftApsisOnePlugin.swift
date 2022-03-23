import Flutter
import UIKit

public class SwiftApsisOnePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "apsis_one", binaryMessenger: registrar.messenger())
    let instance = SwiftApsisOnePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
}
