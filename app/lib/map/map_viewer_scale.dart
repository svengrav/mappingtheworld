import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'map_layer_stack.dart';

typedef OnLayerChanged = void Function(int layer);

class MapLayerScale extends StatefulWidget {
  const MapLayerScale({super.key, required this.stack, this.onLayerChanged});

  static const width = 400.0;
  static const height = 60.0;

  final OnLayerChanged? onLayerChanged;
  final List<MapLayerStack> stack;

  @override
  State<MapLayerScale> createState() => _MapLayerScaleState();
}

class _MapLayerScaleState extends State<MapLayerScale> {
  late double _currentValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: MapLayerScale.height,
          maxWidth: MapLayerScale.width,
        ),
        child: Slider(
          value: _currentValue,
          min: 0,
          max: widget.stack.length.toDouble() - 1,
          divisions: widget.stack.length - 1,
          onChanged: (double value) {
            setState(() {
              widget.stack.forEachIndexed((i, stack) {
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
