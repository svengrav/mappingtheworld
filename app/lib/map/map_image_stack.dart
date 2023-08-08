import 'package:flutter/material.dart';
import 'package:mtw_app/map/stream/event_builder.dart';
import 'map_image_point.dart';
import 'map_page_content.dart';
import 'model/map_definition.dart';
import 'model/map_stack_definition.dart';

class MapImagestack extends StatelessWidget {
  const MapImagestack({super.key, required this.stack});
  final MapStackDefinition stack;

  @override
  Widget build(BuildContext context) {
    final MapDefinition mapDefinition = MapProvider.of(context);

    return EventBuilder(event: mapDefinition.image.mapStackChanged, builder: (context, value, history) {
        var children = <Widget>[stack.layer.resource];

        var oldVisibileState = history.lastOrNull?.value?[stack.index]?.visible ?? false;
        var newVisibileState = stack.visible;

        Tween<double> fadeTween = Tween<double>(begin: 0, end: 0);
        if(oldVisibileState == true && newVisibileState == false) {
          fadeTween = Tween<double>(begin: 1, end: 0);
        } 
        if(oldVisibileState == false && newVisibileState == true) {
          fadeTween = Tween<double>(begin: 0, end: 1);
        }
        if(oldVisibileState == true && newVisibileState == true) {
          fadeTween = Tween<double>(begin: 1, end: 1);
        }
        if(oldVisibileState == false && newVisibileState == false) {
          fadeTween = Tween<double>(begin: 0, end: 0);
        }

        for (var point in stack.points) {
          children.add(MapImagePoint(pointDefinition: point));
        }

        return TweenAnimationBuilder(
          tween: fadeTween, 
          duration: const Duration(seconds: 1), 
          builder: (BuildContext context, double opacity, Widget? child) {
            if(opacity == 0) {
              return const SizedBox();
            }
            return Opacity(opacity: opacity, child: Stack(children: children,));
      });
    });
  }
}