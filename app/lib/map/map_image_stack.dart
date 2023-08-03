import 'package:flutter/material.dart';
import 'package:mtw_app/utils/notifier.dart';
import 'map_image_point.dart';
import 'model/map_stack_definition.dart';

class MapImageStack extends StatefulWidget {
  const MapImageStack({super.key, required this.layer});

  final MapStackDefinition layer;

  @override
  State<MapImageStack> createState() => _MapImageStackState();
}

class _MapImageStackState extends State<MapImageStack> {

  double _opacityLevel = 1.0;
  bool _visiblity = true;

  late final ValueListener _stackListener = ValueListener((sender, args) {
    if (widget.layer.visible) {
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[widget.layer.layer.resource];
    for (var point in widget.layer.points) {
      children.add(MapImagePoint(pointDefinition: point));
    }

    return AnimatedOpacity(
      onEnd: () {
        setState(() {
          _visiblity = widget.layer.visible;
        });
      },
      duration: const Duration(milliseconds: 500),
      opacity: _opacityLevel,
      child: _visiblity
          ? Stack(
              children: children,
            )
          : const SizedBox(),
    );
  }
}
