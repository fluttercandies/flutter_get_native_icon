import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  final EdgeInsetsGeometry? margin;
  final BoxShape shape;
  final BorderRadius? borderRadius;

  const NativeAppIconWidget({
    this.width = 40,
    this.height = 40,
    this.fit = BoxFit.cover,
    this.colorBlendMode,
    this.color,
    this.opacity,
    this.alignment,
    this.margin,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  State<NativeAppIconWidget> createState() => _NativeAppIconWidgetState();
}

class _NativeAppIconWidgetState extends State<NativeAppIconWidget> {
  late final Widget _cachedIcon;

  @override
  void initState() {
    super.initState();
    _cachedIcon = _AppIcon(
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      colorBlendMode: widget.colorBlendMode,
      color: widget.color,
      opacity: widget.opacity,
      alignment: widget.alignment,
      margin: widget.margin,
      shape: widget.shape,
      borderRadius: widget.borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) => _cachedIcon;
}

class _AppIcon extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BlendMode? colorBlendMode;
  final Color? color;
  final Animation<double>? opacity;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final BoxShape shape;
  final BorderRadius? borderRadius;

  const _AppIcon({
    this.width,
    this.height,
    this.fit,
    this.colorBlendMode,
    this.color,
    this.opacity,
    this.alignment,
    this.margin,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  State<_AppIcon> createState() => __AppIconState();
}

class __AppIconState extends State<_AppIcon> {
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
      if (kDebugMode) {
        print(
            "[plugin] flutter_get_native_icon\n__AppIconState::_error ==> ${e.toString()}");
      }
      setState(() {
        _error = "Failed to get app icon path: '${e.message}'.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      content = const CircularProgressIndicator();
    } else if (_error != null ||
        _appIconPath == null ||
        _appIconPath!.isEmpty) {
      content = const Text('Failed to load app icon');
    } else {
      content = Image.memory(
        base64Decode(_appIconPath!),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        color: widget.color,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        alignment: widget.alignment ?? Alignment.center,
      );

      if (widget.shape == BoxShape.circle || widget.borderRadius != null) {
        content = ClipPath(
          clipper: ShapeBorderClipper(
            shape: widget.shape == BoxShape.circle
                ? const CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: widget.borderRadius ?? BorderRadius.zero,
                  ),
          ),
          child: content,
        );
      }
    }

    if (widget.margin != null) {
      content = Padding(
        padding: widget.margin!,
        child: content,
      );
    }

    return content;
  }
}
