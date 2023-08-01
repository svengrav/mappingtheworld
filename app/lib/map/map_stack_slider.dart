import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:mtw_app/map/map_point_definition.dart';
import 'map_position.dart';

typedef OnLayerChanged = void Function(int layer);

class MapStackSlider extends StatefulWidget {
  const MapStackSlider({
    super.key,
    required this.image,
    this.onLayerChanged,
    required this.position,
  });

  final OnLayerChanged? onLayerChanged;
  final MapImageDefinition image;
  final MapPosition position;

  @override
  State<MapStackSlider> createState() => _MapStackSliderState();
}

class _MapStackSliderState extends State<MapStackSlider> {
  late double _currentValue = 1.0;
  late List<MapStackLayerDefinition> _stacks;

  @override
  void initState() {
    super.initState();
    _stacks = widget.image.stacks;
    _currentValue = widget.image.currentStackIndex.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    _stacks = widget.image.stacks;

    return widget.position.build(
      Transform.scale(
        scale: 0.8,
        child: Slider(
          value: _currentValue,
          min: 0,
          max: _stacks.length - 1,
          divisions: _stacks.length - 1,
          onChanged: (double value) {
            setState(() {
              _stacks.forEachIndexed((i, stack) {
                if (i <= value) {
                  stack.controller.show();
                } else {
                  stack.controller.hide();
                }
              });
              _currentValue = value;
              widget.image.controller.notify(this);
            });
            widget.onLayerChanged?.call(value.toInt());
          },
        ),
      ),
    );
  }
}
