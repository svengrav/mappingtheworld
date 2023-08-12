import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_definition.dart';
import 'map_provider.dart';
import 'model/map_position.dart';
import 'stream/event_builder.dart';

class MapStackSlider extends StatelessWidget {
  final MapPosition position;

  const MapStackSlider({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final MapDefinition mapDefinition = MapProvider.of(context);

    return EventBuilder(
        event: mapDefinition.image.mapStackChanged,
        builder: (context, value, history) {
          MapDefinition mapDefinition = MapProvider.of(context);
          double maxStacks = mapDefinition.image.stacks.length - 1;
          double stackIndex = mapDefinition.image.currentStackIndex.toDouble();

          return position.build(
            Transform.scale(
              scale: 0.8,
              child: Slider(
                label: mapDefinition.image.getStack(stackIndex.toInt()).label,
                value: stackIndex,
                min: 0,
                max: maxStacks,
                divisions: maxStacks.toInt(),
                onChanged: (double value) {
                  mapDefinition.image.setStackIndex(value.toInt());
                },
              ),
            ),
          );
        });
  }
}
