# flutter_get_native_icon

flutter_get_native_icon on pub: https://pub.dev/packages/flutter_get_native_icon

Get native icon as flutter widget, Get system desktop app icon and name.

Start with version 0.0.5: support android and ios.

## Getting Started

depend on the plugin in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_get_native_icon: ^0.0.5
```

import the plugin.

```dart
import 'package:flutter_get_native_icon/flutter_get_native_icon.dart';
```

use the widget

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('App Icon Display'),
    ),
    body: Center(child: NativeAppIconWidget()),
  );
}
```

the `NativeAppIconWidget()` you can use in any where.

# Recommended Tools
use flutter_launcher_icons to generate the app icon.
pub: https://pub.dev/packages/flutter_launcher_icons

and please do not use `icons_launcher` because
https://github.com/mrrhak/icons_launcher/issues/70


## Properties

| Property | Type | Description |
|----------|------|-------------|
| `width` | `double?` | The width of the icon |
| `height` | `double?` | The height of the icon |
| `fit` | `BoxFit?` | How the icon should be inscribed into its box |
| `color` | `Color?` | The color to tint the icon with |
| `colorBlendMode` | `BlendMode?` | The blend mode for applying the color |
| `opacity` | `Animation<double>?` | The opacity of the icon |
| `alignment` | `AlignmentGeometry?` | How to align the icon within its bounds |
| `margin` | `EdgeInsetsGeometry?` | The margin around the icon |
| `shape` | `BoxShape` | The shape of the icon (rectangle or circle) |
| `borderRadius` | `BorderRadius?` | The border radius when shape is rectangle |


## About get native app Name
see `package_info_plus` plugin and use code:
```dart
  Future<void> _loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
    });
  }
```

## picture
![App Icon](img/2024-11-21%2011.16.33.jpeg)

# fully demo

```dart
import 'package:flutter/material.dart';
import 'package:flutter_get_native_icon/flutter_get_native_icon.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Icon Display'),
      ),
      body: Center(child: NativeAppIconWidget()),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}
```
