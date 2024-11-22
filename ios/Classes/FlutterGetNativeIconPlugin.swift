import Flutter
import UIKit

public class FlutterGetNativeIconPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_get_native_icon", binaryMessenger: registrar.messenger())
        let instance = FlutterGetNativeIconPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getAppIconPath":
            if let icon = getAppIcon(),
                let iconData = icon.pngData() {
                let iconBase64String = iconData.base64EncodedString()
                result(iconBase64String)
            } else {
                result(FlutterError(code: "UNAVAILABLE", message: "App icon not available", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func getAppIcon() -> UIImage? {
        // get the CFBundleIcons of Info.plist.
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcons = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcons["CFBundleIconFiles"] as? [String],
              let lastIconName = iconFiles.last else {
            print("App icon not found in Info.plist")
            return nil
        }
        
        // Get the App icon image
        return UIImage(named: lastIconName)
    }
}
