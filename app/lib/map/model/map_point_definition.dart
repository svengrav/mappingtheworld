import 'package:flutter/material.dart';
import 'map_key.dart';

@immutable
class MapPointDefinition {
  final MapKey key;
  final List<MapKey> layerKeys;
  final Offset position;
  final bool visible;
  final String label;
  final String? summary;
  final String? description;

  const MapPointDefinition({
    required this.key,
    required this.position,
    required this.label,
    this.visible = true,
    this.layerKeys = const [],
    this.summary,
    this.description,
  });

  @override
  String toString() {
    return 'key: ${key.value} - label: $label - visible: $visible';
  }

  MapPointDefinition copyWith({
    MapKey? key,
    bool? visible,
    Offset? position,
    String? label,
    String? summary,
    String? description,
  }) => MapPointDefinition(
    key: key ?? this.key,
    position: position ?? this.position,
    visible: visible ?? this.visible,
    label: label ?? this.label,
    summary: summary ?? this.summary,
    description: description ?? this.description);
}
