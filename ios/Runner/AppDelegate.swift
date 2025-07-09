import UIKit
import Flutter
import AppTrackingTransparency
import AdSupport

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Викликаємо ATT-промпт
    requestTrackingPermission()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func requestTrackingPermission() {
    // iOS 14+
    if #available(iOS 14, *) {
      ATTrackingManager.requestTrackingAuthorization { status in
        DispatchQueue.main.async {
          let idfa: String
          if status == .authorized {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
          } else {
            idfa = "00000000-0000-0000-0000-000000000000"
          }
          // Зберігаємо IDFA в UserDefaults (або SharedPreferences через плагін)
          UserDefaults.standard.set(idfa, forKey: "advertising_id")
          print("🔔 ATT status: \(status.rawValue), saved IDFA: \(idfa)")
        }
      }
    }
  }
}
