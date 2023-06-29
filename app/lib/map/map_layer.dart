import 'package:flutter/material.dart';

import 'map_resource.dart';

class MapLayer extends StatefulWidget {
  const MapLayer({
    super.key,
    required this.resource,
    this.label,
  });

  final MapResource resource;
  final String? label;

  @override
  State<MapLayer> createState() => _MapLayerState();
}

class _MapLayerState extends State<MapLayer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.resource;
  }
}