import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_point_definition.dart';

import 'map_position.dart';
import 'map_navigator.dart';
import 'map_screen_viewer.dart';

class MapImage extends StatelessWidget {
  const MapImage({
    super.key,
    required this.controller,
    required this.navigator,
    required this.stack,
    required this.position,
  });

  final TransformationController controller;
  final MapNavigator navigator;
  final MapImageDefinition stack;
  final MapPosition position;

  @override
  Widget build(BuildContext context) {
    return position.build(
      MapViewer(
        height: position.height,
        width: position.width,
        transformationController: controller,
        navigator: navigator,
        stack: stack,
      ),
    );
  }
}
