import 'package:flutter/material.dart';

import '../map_resource.dart';
import 'map_key.dart';

@immutable
class MapLayerDefinition {
  final MapKey key;

  final Offset position;
  final String label;
  final MapResource resource;
  final String? summary;
  final String? description;

  const MapLayerDefinition({
    required this.key,
    required this.label,
    required this.resource,
    this.position = const Offset(0, 0),
    this.summary,
    this.description,
  });

  @override
  String toString() {
    return 'key: ${key.value} - label: $label';
  }

  MapLayerDefinition copyWith({
    MapKey? key,
    String? label,
    MapResource? resource,
    Offset? position,
    String? summary,
    String? description,
  }) =>
      MapLayerDefinition(
        key: key ?? this.key,
        label: label ?? this.label,
        resource: resource ?? this.resource,
        position: position ?? this.position,
        summary: summary ?? this.summary,
        description: description ?? this.description,
      );
}
