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

class _MapLayerStackState extends State<MapLayerStack> {
  double _opacityLevel = 1.0;
  bool _visiblity = true;

  late final ValueListener _stackListener = ValueListener((sender, args) {
    if (widget.layer.controller.visible) {
      setState(() {
        _opacityLevel = 1;
      });
    } else {
      setState(() {
        _opacityLevel = 0;
      });
    }
  });

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

    return AnimatedOpacity (
      onEnd: () {
        setState(() {
          _visiblity = widget.layer.controller.visible;
        });
      },
      duration: const Duration(milliseconds: 500),
      opacity: _opacityLevel,
      child: _visiblity ? Stack(
        children: children,
      ) : const SizedBox(),
    );
  }
}
