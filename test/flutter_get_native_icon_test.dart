import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_get_native_icon/flutter_get_native_icon.dart';
import 'package:flutter_get_native_icon/flutter_get_native_icon_platform_interface.dart';
import 'package:flutter_get_native_icon/flutter_get_native_icon_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterGetNativeIconPlatform
    with MockPlatformInterfaceMixin
    implements FlutterGetNativeIconPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterGetNativeIconPlatform initialPlatform = FlutterGetNativeIconPlatform.instance;

  test('$MethodChannelFlutterGetNativeIcon is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterGetNativeIcon>());
  });

  test('getPlatformVersion', () async {
    FlutterGetNativeIcon flutterGetNativeIconPlugin = FlutterGetNativeIcon();
    MockFlutterGetNativeIconPlatform fakePlatform = MockFlutterGetNativeIconPlatform();
    FlutterGetNativeIconPlatform.instance = fakePlatform;

    expect(await flutterGetNativeIconPlugin.getPlatformVersion(), '42');
  });
}
