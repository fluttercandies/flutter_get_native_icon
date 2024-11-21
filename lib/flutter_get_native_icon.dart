import 'flutter_get_native_icon_platform_interface.dart';

export 'native_app_icon_widget.dart';

class FlutterGetNativeIcon {
  Future<String?> getPlatformVersion() {
    return FlutterGetNativeIconPlatform.instance.getPlatformVersion();
  }
}
