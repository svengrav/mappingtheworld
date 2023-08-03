// ignore: unused_import
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_point_definition.dart';
import 'package:mtw_app/utils/extensions.dart';

import 'map_image_point_content.dart';

class MapImagePoint extends StatefulWidget {
  const MapImagePoint({
    required this.pointDefinition,
    super.key,
  });

  final MapPointDefinition pointDefinition;

  @override
  State<MapImagePoint> createState() => _MapImagePointState();
}

class _MapImagePointState extends State<MapImagePoint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final MapPointDefinition _pointDefinition;

  @override
  void initState() {
    super.initState();
    _pointDefinition = widget.pointDefinition;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dialogSize = EdgeInsets.symmetric(
        horizontal: (context.getScreenWidth() - 300) / 2,
        vertical: (context.getScreenHeight() - 300) / 2);

    return Align(
        alignment: FractionalOffset(
            _pointDefinition.position.dx, _pointDefinition.position.dy),
        child: MapPointTarget(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => MapImagePointContent(
                pointDefinition: _pointDefinition, 
                dialogSize: dialogSize),
          ),
        ));
  }
}

class MapPointTarget extends StatefulWidget {
  const MapPointTarget({super.key, required this.onTap});
  final void Function() onTap;
  final double circle = 15;

  @override
  State<MapPointTarget> createState() => _MapPointTargetState();
}

class _MapPointTargetState extends State<MapPointTarget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hovering) {
        setState(() => _isHovering = hovering);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        height: widget.circle,
        width: widget.circle,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.circle),
          border: Border.all(
              color: _isHovering ? Colors.cyan : Colors.white, width: 1.5),
        ),
      ),
    );
  }
}
