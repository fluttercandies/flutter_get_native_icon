# flutter_get_native_icon

Get native icon as flutter widget, Get system desktop app icon and name.

only support ios now.

## Getting Started

depend on the plugin in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_get_native_icon: ^0.0.3
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

- `width`: The width of the icon.
- `height`: The height of the icon.
- `fit`: How the icon should be inscribed into the space allocated during layout.
- `colorBlendMode`: The blend mode applied to the icon.
- `color`: The color to use when drawing the icon.
- `opacity`: The opacity to apply to the icon.
- `alignment`: How to align the icon within its bounds.


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