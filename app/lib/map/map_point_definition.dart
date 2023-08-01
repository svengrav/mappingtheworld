
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_navigator.dart';
import 'package:mtw_app/map/map_position.dart';
import 'package:mtw_app/utils/extensions.dart';
import 'package:equatable/equatable.dart';


import 'map_resource.dart';

class MapImageDefinition {
  static const String layerKeyNotUnique = "Layers with the same key are invalid";
  static const String pointKeyNotUnique = "Points with the same key are invalid";

  final List<MapStackLayerDefinition> _stacks = [];
  final MapNavigator navigator;

  final List<MapPointDefinition> mapPoints;
  final List<MapLayerDefinition> mapLayers;
  final MapLayerDefinitionKey defaultLayerKey;

  final MapVisibilityController controller = MapVisibilityController();

  int _currentStackIndex = -1;
  int get currentStackIndex => _currentStackIndex;

  MapStackLayerDefinition get defaultStack => _getDefaultLayer(defaultLayerKey);
  List<MapStackLayerDefinition> get stacks => _stacks;

  MapImageDefinition({
    required this.navigator,
    required Object defaultLayerKey,
    this.mapPoints = const [],
    this.mapLayers = const [],
  }) : defaultLayerKey = MapLayerDefinitionKey(defaultLayerKey) {

    assert(mapLayers.isSingle((layer) => layer.key.value, defaultLayerKey), layerKeyNotUnique);
    assert(mapLayers.isUnique((layer) => layer.key), layerKeyNotUnique);
    assert(mapPoints.isUnique((point) => point.key), pointKeyNotUnique);

    _currentStackIndex = _getStackIndex();
    _stacks.addAll(_buildStacks(mapLayers, mapPoints));
  }

  MapStackLayerDefinition _getDefaultLayer(MapLayerDefinitionKey key) {
    return _stacks.firstWhere((stack) => stack.key == key);
  }

  int _getStackIndex() {
    var stackIndex = _currentStackIndex;
    if(stackIndex < 0) {
        mapLayers.asMap().forEach((index, layer) {
        if(layer.key == defaultLayerKey) {
          stackIndex = index;
        }
      });
    }

    return stackIndex;
  }

  List<MapStackLayerDefinition> _buildStacks(
    List<MapLayerDefinition> mapLayers,
    List<MapPointDefinition> mapPoints,
  ) {    
    List<MapStackLayerDefinition> stacks = [];
    mapLayers.asMap().forEach((index, layer) { 
      stacks.add(MapStackLayerDefinition(
        visible: index >= _getStackIndex(),
        index: index,
        layer: layer,
        points: mapPoints
            .where((point) => point.layerKeys.contains(layer.key))
            .toList(),
      ));
    });
    return stacks;
  }
}


class MapPointDefinitionKey extends MapDefintionKey {
  MapPointDefinitionKey(super.value);
}

class MapStackLayerDefinition extends Equatable {
  final bool visible;
  final int index;
  final MapLayerDefinition layer;
  final List<MapPointDefinition> points;
  final MapVisibilityController controller = MapVisibilityController();

  MapLayerDefinitionKey get key => layer.key;

  MapStackLayerDefinition({
    required this.visible,
    required this.layer,
    required this.index,
    this.points = const [],
  });
  
  @override
  List<Object?> get props => [visible, index, layer, points];
}

class MapPointDefinition {
  final List<MapLayerDefinitionKey> layerKeys;
  final MapPointDefinitionKey key;
  final Offset position;
  final bool visible;
  final String label;
  final String? summary;
  final String? description;

  MapPointDefinition({
    required Object key,
    required this.position,
    required this.label,
    this.visible = true,
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
    required Object key,
    required this.label,
    required this.resource,
    this.position = const Offset(0, 0),
    this.pointKeys = const [],
    this.summary,
    this.description,
  }) : key = MapLayerDefinitionKey(key);
}

class MapDefintionKey {
  final Object value;

  MapDefintionKey(this.value);

  @override
  bool operator ==(Object other) =>
      other is MapDefintionKey &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;
}