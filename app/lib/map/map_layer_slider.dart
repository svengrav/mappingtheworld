import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'map_position.dart';
import 'map_layer_stack.dart';

typedef OnLayerChanged = void Function(int layer);

class MapLayerSlider extends StatefulWidget {
  const MapLayerSlider({
    super.key,
    required this.layer,
    this.onLayerChanged,
    required this.position,
  });

  final OnLayerChanged? onLayerChanged;
  final List<MapLayerStack> layer;
  final MapPosition position;

  @override
  State<MapLayerSlider> createState() => _MapLayerSliderState();
}

class _MapLayerSliderState extends State<MapLayerSlider> {
  late double _currentValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return widget.position.build(
      Transform.scale(
        scale: 0.8,
        child: Slider(
          value: _currentValue,
          min: 0,
          max: widget.layer.length.toDouble() - 1,
          divisions: widget.layer.length - 1,
          onChanged: (double value) {
            setState(() {
              widget.layer.forEachIndexed((i, stack) {
                if (i <= value) {
                  stack.show();
                } else {
                  stack.hide();
                }
              });
              _currentValue = value;
            });
            widget.onLayerChanged?.call(value.toInt());
          },
        ),
      ),
    );
  }
}
