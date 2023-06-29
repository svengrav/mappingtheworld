import 'package:flutter/material.dart';
import 'package:mtw_app/utils/extensions.dart';
import 'map_layer_stack.dart';
import 'map_navigator.dart';

class MapViewer extends StatelessWidget {
  final TransformationController transformationController;
  final MapNavigator navigator;
  final List<MapLayerStack> layer;
  final double height;
  final double width;

  const MapViewer({
    super.key,
    required this.transformationController,
    required this.navigator,
    required this.layer,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        constrained: true,
        transformationController: transformationController,
        onInteractionEnd: (details) {},
        onInteractionUpdate: handleInteractionUpdate,
        clipBehavior: Clip.hardEdge,
        boundaryMargin: const EdgeInsets.all(0.0),
        minScale: 1,
        maxScale: navigator.mapMaxScale,
        child: Stack(
          children: layer,
        ),
      );
  }

  void handleInteractionUpdate(details) {
    navigator.set(
        mapScale: transformationController.getScale(),
        mapHorizontalOffset: transformationController.getXOffset(),
        mapVerticalOffset: transformationController.getYOffset(),
        cursorHorizontal: details.focalPoint.dx,
        cursorVertical: details.focalPoint.dy);
  }
}
