import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:mtw_app/map/map_point_definition.dart';
import 'map_position.dart';

typedef OnLayerChanged = void Function(int layer);

class MapLayerSlider extends StatefulWidget {
  const MapLayerSlider({
    super.key,
    required this.stack,
    this.onLayerChanged,
    required this.position,
  });

  final OnLayerChanged? onLayerChanged;
  final MapImageDefinition stack;
  final MapPosition position;

  @override
  State<MapLayerSlider> createState() => _MapLayerSliderState();
}

class _MapLayerSliderState extends State<MapLayerSlider> {
  late double _currentValue = 1.0;
  late List<MapStackLayerDefinition> _stack;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.stack.stacks.reversed.toList().indexOf(widget.stack.defaultStack).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    _stack = widget.stack.stacks;

    return widget.position.build(
      Transform.scale(
        scale: 0.8,
        child: Slider(
          value: _currentValue,
          min: 0,
          max: widget.stack.mapLayers.length - 1,
          divisions: widget.stack.mapLayers.length - 1,
          onChanged: (double value) {
            setState(() {
              _stack.forEachIndexed((i, stack) {
                if (i <= value) {
                  stack.controller.show();
                } else {
                  stack.controller.hide();
                }
              });
              _currentValue = value;
              widget.stack.controller.notify(this);
            });
            widget.onLayerChanged?.call(value.toInt());
          },
        ),
      ),
    );
  }
}
