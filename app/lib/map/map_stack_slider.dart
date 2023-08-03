import 'dart:math';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:mtw_app/map/model/map_definition.dart';
import 'package:mtw_app/map/map_page_content.dart';
import 'package:mtw_app/map/model/map_point_definition.dart';
import 'package:mtw_app/utils/notifier.dart';
import 'map_position.dart';
import 'model/map_image_definition.dart';
import 'model/map_stack_definition.dart';

typedef MapImageListenerBuilder = Widget Function(BuildContext context);

class MapImageListener extends StatefulWidget {
  final BuildContext context;
  final MapImageListenerBuilder builder;
  const MapImageListener({super.key, required this.context, required this.builder});

  @override
  State<MapImageListener> createState() => _MapImageListenerState();
}

class _MapImageListenerState extends State<MapImageListener> {
  late MapDefinition _mapDefinition;
  late int random = Random().nextInt(100);
  late NotifierListener listener;

  @override
  void initState() {
    listener = NotifierListener((sender, args) => { setState(() {
      random = Random().nextInt(100);
    },)});

    _mapDefinition = MapProvider.of<MapDefinition>(context);
    _mapDefinition.image.controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _mapDefinition.image.controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: ValueKey(random), child: widget.builder.call(context));
  }
}


class MapStackSlider2 extends StatelessWidget {
  final MapPosition position;

  const MapStackSlider2({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return MapImageListener(context: context, builder: (context) { 
        MapDefinition mapDefinition = MapProvider.of(context);
        double maxStacks = mapDefinition.image.stacks.length - 1;
        double stackIndex = mapDefinition.image.currentStackIndex.toDouble();

      return position.build(
        Transform.scale(
          scale: 0.8,
          child: Slider(
            value: stackIndex,
            min: 0,
            max: maxStacks,
            divisions: maxStacks.toInt(),
            onChanged: (double value) {
              mapDefinition.image.setStackIndex(value.toInt());
            },
          ),
        ),
      );}
    );
  }
}