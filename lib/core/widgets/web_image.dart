import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Counter to generate unique view IDs for each image.
int _viewCounter = 0;

/// Registers an HTML <img> element and returns the view type string.
String _registerImageView(String url, String fit) {
  final viewType = '__web_img_${_viewCounter++}';
  ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final img = web.document.createElement('img') as web.HTMLImageElement;
    img.src = url;
    img.style
      ..width = '100%'
      ..height = '100%'
      ..objectFit = fit
      ..display = 'block';
    return img;
  });
  return viewType;
}

/// An image widget that renders via an HTML <img> tag on Flutter web.
/// This bypasses CanvasKit CORS issues entirely.
class WebImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const WebImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<WebImage> createState() => _WebImageState();
}

class _WebImageState extends State<WebImage> {
  late final String _viewType;

  String _fitToCss(BoxFit fit) {
    switch (fit) {
      case BoxFit.cover:
        return 'cover';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
      default:
        return 'cover';
    }
  }

  @override
  void initState() {
    super.initState();
    _viewType = _registerImageView(widget.url, _fitToCss(widget.fit));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
