import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_get_native_icon_platform_interface.dart';

/// An implementation of [FlutterGetNativeIconPlatform] that uses method channels.
class MethodChannelFlutterGetNativeIcon extends FlutterGetNativeIconPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_get_native_icon');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
