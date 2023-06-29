// ignore: unused_import
import 'dart:math' as math;
import 'package:flutter/material.dart';

class MapPoint extends StatefulWidget {
  const MapPoint({
    super.key,
    required this.offset,
    this.layer = const [],
  });

  final FractionalOffset offset;
  final List<int> layer;

  @override
  State<MapPoint> createState() => _MapPointState();
}

class _MapPointState extends State<MapPoint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.offset,
      child: SizedBox(
          height: 10,
          width: 10,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 152, 255),
              borderRadius: BorderRadius.circular(10),
            ),
          )),
    );
  }
}
