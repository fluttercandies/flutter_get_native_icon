import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeAppIconWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BlendMode? colorBlendMode;
  final Color? color;
  final Animation<double>? opacity;
  final AlignmentGeometry? alignment;

  NativeAppIconWidget({
    this.width,
    this.height,
    this.fit,
    this.colorBlendMode,
    this.color,
    this.opacity,
    this.alignment,
  });

  @override
  _NativeAppIconWidgetState createState() => _NativeAppIconWidgetState();
}

class _NativeAppIconWidgetState extends State<NativeAppIconWidget> {
  static const platform = MethodChannel('flutter_get_native_icon');

  Future<String> _getAppIconPath() async {
    try {
      final String result = await platform.invokeMethod('getAppIconPath');
      print("get ios native icon result::$result");
      return result;
    } on PlatformException catch (e) {
      print("Failed to get app icon path: '${e.message}'.");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppIconPath(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return Text('Failed to load app icon');
        } else {
          return Image.memory(
            base64Decode(snapshot.data!),
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            color: widget.color,
            opacity: widget.opacity,
            colorBlendMode: widget.colorBlendMode,
            alignment: widget.alignment ?? Alignment.center,
          );
        }
      },
    );
  }
}
