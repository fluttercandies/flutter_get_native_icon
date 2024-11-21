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
  String? _appIconPath;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _getAppIconPath();
  }

  Future<void> _getAppIconPath() async {
    try {
      final String result = await platform.invokeMethod('getAppIconPath');
      setState(() {
        _appIconPath = result;
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _error = "Failed to get app icon path: '${e.message}'.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator();
    } else if (_error != null ||
        _appIconPath == null ||
        _appIconPath!.isEmpty) {
      return Text('Failed to load app icon');
    } else {
      return Image.memory(
        base64Decode(_appIconPath!),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        color: widget.color,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        alignment: widget.alignment ?? Alignment.center,
      );
    }
  }
}
