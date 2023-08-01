// ignore: unused_import
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_point_definition.dart';
import 'package:mtw_app/utils/extensions.dart';

class MapPoint extends StatefulWidget {
  const MapPoint({
    required this.pointDefinition,
    super.key,
  });

  final MapPointDefinition pointDefinition;

  @override
  State<MapPoint> createState() => _MapPointState();
}

class _MapPointState extends State<MapPoint>
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
            builder: (BuildContext context) => MapPointContent(
                pointDefinition: _pointDefinition, 
                dialogSize: dialogSize),
          ),
        ));
  }
}

class MapPointContent extends StatelessWidget {
  const MapPointContent({
    super.key,
    required MapPointDefinition pointDefinition,
    required this.dialogSize,
  }) : _pointDefinition = pointDefinition;

  final MapPointDefinition _pointDefinition;
  final EdgeInsets dialogSize;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: const RoundedRectangleBorder(),
        titlePadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_pointDefinition.label,
                style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
              visualDensity: VisualDensity.comfortable,
            )
          ],
        ),
        insetPadding: dialogSize,
        children: [
          Text(
            _pointDefinition.description ?? "",
          )
        ]);
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
