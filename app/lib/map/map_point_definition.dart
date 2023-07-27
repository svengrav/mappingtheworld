import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mtw_app/utils/extensions.dart';

import 'map_resource.dart';

class MapStackLayerDefinition {
  final MapLayerDefinition layer;
  final List<MapPointDefinition> points;

  MapLayerDefinitionKey get key => layer.key;

  MapStackLayerDefinition({
    required this.layer,
    this.points = const [],
  });
}

class MapStackDefinition {
  static const String layerKeyNotUnique = "Layers with the same key are invalid";
  static const String pointKeyNotUnique = "Points with the same key are invalid";

  final List<MapStackLayerDefinition> _stacks = [];

  final List<MapPointDefinition> mapPoints;
  final List<MapLayerDefinition> mapLayers;
  final MapLayerDefinitionKey defaultLayerKey;

  MapStackLayerDefinition get defaultStack => _getDefaultLayer(defaultLayerKey);
  List<MapStackLayerDefinition> get stacks => _stacks;

  MapStackDefinition({
    required String defaultLayerKey,
    this.mapPoints = const [],
    this.mapLayers = const [],
  }) : defaultLayerKey = MapLayerDefinitionKey(defaultLayerKey) {

    assert(mapLayers.isSingle((layer) => layer.key.value, defaultLayerKey), layerKeyNotUnique);
    assert(mapLayers.isUnique((layer) => layer.key), layerKeyNotUnique);
    assert(mapPoints.isUnique((point) => point.key), pointKeyNotUnique);

    _stacks.addAll(_createStacks(mapLayers, mapPoints));
  }

  MapStackLayerDefinition _getDefaultLayer(MapLayerDefinitionKey key) {
    return _stacks.firstWhere((stack) => stack.key == key);
  }

  List<MapStackLayerDefinition> _createStacks(
    List<MapLayerDefinition> mapLayers,
    List<MapPointDefinition> mapPoints,
  ) {
    List<MapStackLayerDefinition> stacks = [];
    for (var layer in mapLayers) {
      stacks.add(MapStackLayerDefinition(
        layer: layer,
        points: mapPoints
            .where((element) => element.layerKeys.contains(layer.key))
            .toList(),
      ));
    }
    return stacks;
  }
}


class MapPointDefinitionKey extends MapDefintionKey {
  MapPointDefinitionKey(super.value);
}

class MapPointDefinition {
  final List<MapLayerDefinitionKey> layerKeys;
  final MapPointDefinitionKey key;
  final Offset position;
  final String label;
  final String? summary;
  final String? description;

  MapPointDefinition({
    required String key,
    required this.position,
    required this.label,
    this.layerKeys = const [],
    this.summary,
    this.description,
  }) : key = MapPointDefinitionKey(key);
}

class MapLayerDefinitionKey extends MapDefintionKey {
  MapLayerDefinitionKey(super.value);
}

class MapLayerDefinition {
  final List<MapPointDefinitionKey> pointKeys;

  final MapLayerDefinitionKey key;

  final Offset position;
  final String label;
  final MapResource resource;
  final String? summary;
  final String? description;

  MapLayerDefinition({
    required String key,
    required this.label,
    required this.resource,
    this.position = const Offset(0, 0),
    this.pointKeys = const [],
    this.summary,
    this.description,
  }) : key = MapLayerDefinitionKey(key);
}

class MapDefintionKey {
  final String value;

  MapDefintionKey(this.value);

  @override
  bool operator ==(Object other) =>
      other is MapDefintionKey &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;
}