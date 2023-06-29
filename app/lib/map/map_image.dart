import 'package:flutter/material.dart';

import 'map_position.dart';
import 'map_layer_stack.dart';
import 'map_navigator.dart';
import 'map_screen_viewer.dart';

class MapImage extends StatelessWidget {
  const MapImage({
    super.key,
    required this.controller,
    required this.navigator,
    required this.layer,
    required this.position,
  });

  final TransformationController controller;
  final MapNavigator navigator;
  final List<MapLayerStack> layer;
  final MapPosition position;

  @override
  Widget build(BuildContext context) {
    return position.build(
      MapViewer(
        height: position.height,
        width: position.width,
        transformationController: controller,
        navigator: navigator,
        layer: layer,
      ),
    );
  }
}
