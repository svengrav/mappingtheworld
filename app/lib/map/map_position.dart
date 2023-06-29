import 'package:flutter/material.dart';

import '../utils/notifier.dart';

class MapPositionController with Notifier {
  MapPositionController({visible = true}) : _isVisible = visible;

  bool _isVisible = false;

  bool get visible => _isVisible;

  void show() {
    _isVisible = true;
    notify(this);
  }

  void hide() {
    _isVisible = false;
    notify(this); 
  }
}

class MapPosition {
  static MapPosition empty = MapPosition(pageWidth: 0, pageHeight: 0);

  Rect _rectangle = Rect.zero;
  Alignment _alignChild = Alignment.topLeft;
  final MapPositionController _controller;

  double _pageWidth;
  double _pageHeight;

  double get top => _rectangle.top;
  double get right => _pageWidth - _rectangle.right;
  double get bottom => _pageHeight - _rectangle.bottom;
  double get left => _rectangle.left;
  double get width => _rectangle.width;
  double get height => _rectangle.height;
  double get pageWidth => _pageWidth;
  double get pageHeight => _pageHeight;
  MapPositionController get controller => _controller;

  MapPosition({
    required double pageWidth,
    required double pageHeight,
    MapPositionController? controller,
    double? width,
    double? height,
    double? top,
    double? right,
    double? bottom,
    double? left,
    Alignment? alignment,
    Alignment? alignChild,
    bool visible = true

  })  : _pageWidth = pageWidth,
        _pageHeight = pageHeight,
        _controller = controller ?? MapPositionController(visible: visible) 
      {
    set(
      width: width,
      height: height,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      alignment: alignment,
      alignChild: alignChild,
      visible: visible
    );
  }

  MapPosition set({
    double? width,
    double? height,
    double? pageWidth,
    double? pageHeight,
    double? top,
    double? right,
    double? bottom,
    double? left,
    Alignment? alignment,
    Alignment? alignChild,
    bool? visible
  }) {
    _pageWidth = pageWidth ?? _pageWidth;
    _pageHeight = pageHeight ?? _pageHeight;
    _alignChild = alignChild ?? _alignChild;

    var canvas = Rect.fromLTRB(0, 0, pageWidth ?? _pageWidth, pageHeight ?? _pageHeight);
    var content = Size(width ?? _rectangle.width, height ?? _rectangle.height);

    _rectangle = canvas.align(alignment, content);

    if (isRightAlignment(left, right, alignment)) {
      left = canvas.width - content.width;
    }

    if (isBottomAlignment(top, bottom, alignment)) {
      top = canvas.height - content.height;
    }

    _rectangle = _rectangle.offset(top, left, bottom, right);
    return this;
  }

  bool isBottomAlignment(double? top, double? bottom, Alignment? alignment) =>
      top == null && bottom != null && alignment == null;

  bool isRightAlignment(double? left, double? right, Alignment? alignment) =>
      left == null && right != null && alignment == null;

  Widget build(Widget child) {
    return controller.visible ? Positioned(
      height: height,
      width: width,
      top: top,
      left: left,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        child: Align(
          alignment: _alignChild,
          child: child,
        ),
      ),
    ) : const Positioned(height: 0, width: 0, child: SizedBox(),);
  }
}

extension on double? {
  double get() => this ?? 0;
}

extension on Rect {
  Rect offset(double? top, double? left, double? bottom, double? right) =>
      translate(left.get() - right.get(), top.get() - bottom.get());

  Rect align(Alignment? alignment, Size size) => alignment != null
      ? alignment.inscribe(size, this)
      : Alignment.topLeft.inscribe(size, this);
}
