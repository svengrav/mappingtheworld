
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_key.dart';

import 'map_layer_definition.dart';
import 'map_point_definition.dart';

@immutable
class MapStackDefinition extends Equatable {
  final int index;
  final bool visible;
  final MapLayerDefinition layer;
  final List<MapPointDefinition> points;

  MapKey get key => layer.key;
  String get label => layer.label;

  const MapStackDefinition({
    required this.index,
    required this.visible,
    required this.layer,
    this.points = const [],
  });
  
  @override
  List<Object?> get props => [visible, index, layer, points];
  
  @override
  String toString() {
    return '$index - label: ${layer.label} - visible: $visible - points: ${points.length}';
  }

  MapStackDefinition copyWith({
    int? index,
    bool? visible,
    MapLayerDefinition? layer,
    List<MapPointDefinition>? points,
  }) => MapStackDefinition(
    index: index ?? this.index,
    visible: visible ?? this.visible,
    layer: layer ?? this.layer,
    points: points ?? this.points);
}