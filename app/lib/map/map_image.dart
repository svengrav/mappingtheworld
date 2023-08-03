import 'package:flutter/material.dart';
import 'package:mtw_app/utils/extensions.dart';

import 'model/map_definition.dart';
import 'map_image_stack.dart';
import 'map_page_content.dart';
import 'map_position.dart';
import 'map_stack_slider.dart';

class MapImage extends StatelessWidget {
  const MapImage({
    super.key,
    required this.position,
  });

  final MapPosition position;

  @override
  Widget build(BuildContext context) {
    final MapDefinition mapDefinition = MapProvider.of(context);
    final TransformationController controller = TransformationController();
    void handleInteractionUpdate(details) {
      mapDefinition.image.navigator.set(
          mapScale: controller.getScale(),
          mapHorizontalOffset: controller.getXOffset(),
          mapVerticalOffset: controller.getYOffset(),
          cursorHorizontal: details.focalPoint.dx,
          cursorVertical: details.focalPoint.dy);
    }

    return MapImageListener(
        context: context,
        builder: (context) {

          var children = <Widget>[];
          for (var layer in mapDefinition.image.stacks) {
            children.add(MapImageStack(layer: layer));
          }

          return position.build(InteractiveViewer(
            constrained: true,
            transformationController: controller,
            onInteractionEnd: (details) {},
            onInteractionUpdate: handleInteractionUpdate,
            clipBehavior: Clip.hardEdge,
            boundaryMargin: const EdgeInsets.all(0.0),
            minScale: 1,
            maxScale: mapDefinition.image.navigator.mapMaxScale,
            child: Stack(
              children: children,
            ),
          ));
        });
  }
}
