import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_get_native_icon_method_channel.dart';

abstract class FlutterGetNativeIconPlatform extends PlatformInterface {
  /// Constructs a FlutterGetNativeIconPlatform.
  FlutterGetNativeIconPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterGetNativeIconPlatform _instance = MethodChannelFlutterGetNativeIcon();

  /// The default instance of [FlutterGetNativeIconPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterGetNativeIcon].
  static FlutterGetNativeIconPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterGetNativeIconPlatform] when
  /// they register themselves.
  static set instance(FlutterGetNativeIconPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
