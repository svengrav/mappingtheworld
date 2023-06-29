import 'package:flutter/material.dart';
import 'package:mtw_app/utils/extensions.dart';
import 'package:mtw_app/utils/notifier.dart';
import 'map_position.dart';

class MapNavigator with Notifier {
  final double mapHeight;
  final double mapWidth;

  MapPosition _mapPosition = MapPosition.empty;
  double _mapScale = 1.0;
  double _pageHeight = 0;
  double _pageWidth = 0;
  double _mapCurrentHeight = 1.0;
  double _mapCurrentWidth = 1.0;
  double _cursorVertical = 0;
  double _cursorHorizontal = 0;
  double _mapHorizontalOffset = 0;
  double _mapVerticalOffset = 0;
  double _shrinkHeight = 0;
  double _shrinkWidth = 0;
  Alignment _alignment = Alignment.topCenter;

  double get mapMaxScale => _calcMaxScale();
  double get mapScale => _mapScale;
  double get pageHeight => _pageHeight;
  double get pageWidth => _pageWidth;
  double get mapCurrentHeight => _mapCurrentHeight;
  double get mapCurrentWidth => _mapCurrentWidth;
  double get cursorVertical => _cursorVertical;
  double get cursorHorizontal => _cursorHorizontal;
  double get mapHorizontalOffset => _mapHorizontalOffset;
  double get mapVerticalOffset => _mapVerticalOffset;
  
  MapPosition get position => _mapPosition;

  MapNavigator({
    required this.mapWidth,
    required this.mapHeight,
    double pageWidth = 0,
    double pageHeight = 0,
  })  : _pageWidth = pageWidth,
        _pageHeight = pageHeight {
    assert(pageWidth >= 0 && pageHeight >= 0,
        'Screen size (x=$pageWidth,y=$pageHeight) cant be negative');
    assert(mapWidth >= 0 && mapHeight >= 0,
        'Map size (x=$mapWidth,y=$mapHeight) cant be negative');
    _calcMapSize();
  }

  /// Creates a string dictionary from the navigator.
  Map<String, String> toDictionary() => {
        'Scale': _mapScale.toStringAsFixed(2),
        'MaxScale': mapMaxScale.toStringAsFixed(2),
        'PageWidth': _pageWidth.toStringAsFixed(2),
        'PageHeight': _pageHeight.toStringAsFixed(2),
        'MapWidth': mapWidth.toStringAsFixed(2),
        'MapHeight': mapHeight.toStringAsFixed(2),
        'MapCurrentWidth': _mapCurrentWidth.toStringAsFixed(2),
        'MapCurrentHeight': _mapCurrentHeight.toStringAsFixed(2),
        'MapShrink': _shrinkRatio().toStringAsFixed(2),
        'CursorVertical': _cursorVertical.toStringAsFixed(2),
        'CursorHorizontal': _cursorHorizontal.toStringAsFixed(2),
        'MapVerticalOffset': _mapVerticalOffset.toStringAsFixed(2),
        'MapHorizontalOffset': _mapHorizontalOffset.toStringAsFixed(2),
      };

  void shrinkPage({double? width, double? height}) {
    set(shrinkWidth: width, shrinkHeight: height);
  }

  /// Sets values for this navigator.
  /// If a value changes, the listeners are notified.
  MapNavigator set({
    double? mapScale,
    double? mapHorizontalOffset,
    double? mapVerticalOffset,
    double? screenHeight,
    double? screenWidth,
    double? cursorVertical,
    double? cursorHorizontal,
    double? shrinkWidth,
    double? shrinkHeight,
    double? top,
    double? bottom,
    double? left,
    double? right,
    Alignment? alignment
  }) {
    var valueChanged = _MapNavigatorValueUpdated();

    _mapScale = _mapScale._change(mapScale, valueChanged);

    _mapVerticalOffset = _mapVerticalOffset._change(mapVerticalOffset, valueChanged);
    _mapHorizontalOffset = _mapHorizontalOffset._change(mapHorizontalOffset, valueChanged);

    _pageWidth = _pageWidth._change(screenWidth, valueChanged);
    _pageHeight = _pageHeight._change(screenHeight, valueChanged);

    _alignment = alignment ?? _alignment;
  
    _shrinkWidth = _shrinkWidth._change(shrinkWidth, valueChanged);
    _shrinkHeight = _shrinkHeight._change(shrinkHeight, valueChanged);

    _cursorVertical = _cursorVertical._change(cursorVertical, valueChanged);
    _cursorHorizontal = _cursorHorizontal._change(cursorHorizontal, valueChanged);

    _mapCurrentWidth = _mapCurrentWidth._change(mapCurrentWidth, valueChanged);
    _mapCurrentHeight = _mapCurrentHeight._change(mapCurrentHeight, valueChanged);

    _calcMapSize();

    _mapPosition = MapPosition(
      pageWidth: _pageWidth, 
      pageHeight: _pageHeight, 
      height: _mapCurrentHeight, 
      width: _mapCurrentWidth, 
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      alignment: _alignment,
    );

    if (valueChanged.isUpdated) {
      notify(this);
    }
    return this;
  }


  /// Calculates the relative horizontal position
  /// on the map using a fixed number of pixels.
  double calcRelativeXPosition(int x) => (x / mapCurrentWidth).toPrecision(2);

  /// Calculates the relative vertical position
  /// on the map using a fixed number of pixels.
  double calcRelativeYPosition(int y) => (y / mapCurrentHeight).toPrecision(2);

  /// Calculates the horizontal pixel position
  /// on the map using a percentage.
  int calcPixelXPosition(double x) => (mapCurrentWidth * x).ceil();

  /// Calculates the vertical pixel position
  /// on the map using a percentage.
  int calcPixelYPosition(double y) => (mapCurrentHeight * y).ceil();

  double _calcMaxScale() => _shrinkRatio() < 1.0 ? 1 / _shrinkRatio() : 1;

  String _toPercentageString(double value) =>
      '${value.toStringAsFixed(2)} (${(value * 100).toStringAsFixed(2)}%)';

  void _calcMapSize() {
    _mapCurrentHeight = _calcMapHeight();
    _mapCurrentWidth = _calcMapWidth();
  }

  double _calcMapHeight() => mapHeight * mapScale * _shrinkRatio();

  double _calcMapWidth() => mapWidth * mapScale * _shrinkRatio();

  double _screenHeightRatio() => _mapHeightConstraints() / mapHeight;

  double _screenWidthRatio() => _mapWidthConstraints() / mapWidth;

  double _mapHeightConstraints() => pageHeight - _shrinkHeight;

  double _mapWidthConstraints() => pageWidth - _shrinkWidth;

  bool _mapIsScaled() => mapScale > 1;

  bool _mapIsUnlimitedByScaleAndScreen() =>
      _mapIsScaled() || (_screenWidthRatio() > 1 && _screenHeightRatio() > 1);

  bool isLimitedByScreenWidth() => _screenWidthRatio() < 1;

  double _shrinkRatio() => _mapIsUnlimitedByScaleAndScreen()
      ? 1
      : (_screenWidthRatio() < _screenHeightRatio())
          ? _screenWidthRatio()
          : _screenHeightRatio();
}

class _MapNavigatorValueUpdated {
  bool isUpdated = false;
}

extension on double {
  double _change(double? value, _MapNavigatorValueUpdated updated) {
    if(value != null && value != this) {
      updated.isUpdated = true;
      return value;
    } else {
      return this;
    }
  }
}
