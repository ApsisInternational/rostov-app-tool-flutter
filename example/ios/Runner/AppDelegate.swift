import UIKit
import Flutter
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager = CLLocationManager()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.locationManager.delegate = self
    self.requestLocationAuthorization()
    GeneratedPluginRegistrant.register(with: self)
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel.init(name: "com.apsis.one/sampleapp", binaryMessenger: controller.binaryMessenger)
      
      channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if ("switchView" == call.method) {
              let platformViewController = PlatformViewController(nibName: "PlatformViewController", bundle: nil)
              
              let navigationController = UINavigationController(rootViewController: platformViewController)
              navigationController.navigationBar.topItem?.title = "Platform View"
              controller.present(navigationController, animated: true, completion: nil)
          } else {
              result(FlutterMethodNotImplemented)
          }
      });
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func requestLocationAuthorization() {
        switch self.locationStatus {
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    private var locationStatus: CLAuthorizationStatus {
        var status: CLAuthorizationStatus = .notDetermined
        if #available(iOS 14.0, *) {
            status = self.locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        return status
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}

}
