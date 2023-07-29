import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_point_definition.dart';
import 'package:mtw_app/utils/notifier.dart';

import 'map_layer_point.dart';

class MapLayerStack extends StatefulWidget {
  const MapLayerStack({super.key, required this.layer});

  final MapStackLayerDefinition layer;

  @override
  State<MapLayerStack> createState() => _MapLayerStackState();
}

class _MapLayerStackState extends State<MapLayerStack>
with SingleTickerProviderStateMixin {

  late final ValueListener _stackListener = ValueListener((sender, args) {
    if (widget.layer.controller.visible) {
      setState(() {
        _controller.animateTo(1.0);
      });
    } else {
      setState(() {
        _controller.animateTo(0.0);
      });
    }
  });

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    value: 1.0,
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    widget.layer.controller.addListener(_stackListener);
  }

  @override
  void dispose() {
    widget.layer.controller.removeListener(_stackListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[widget.layer.layer.resource];
    for(var point in widget.layer.points) {
      children.add(MapPoint(pointDefinition: point));
    }

    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: children,
      ),
    );
  }
}
