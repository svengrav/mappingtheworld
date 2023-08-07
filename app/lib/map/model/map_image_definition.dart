
import 'package:mtw_app/map/map_image_stack.dart';
import 'package:mtw_app/map/stream/event.dart';
import 'package:mtw_app/utils/extensions.dart';

import 'map_key.dart';
import 'map_navigator.dart';
import '../map_position.dart';
import 'map_layer_definition.dart';
import 'map_point_definition.dart';
import 'map_stack_definition.dart';

class MapImageDefinition {  
  static const String layerKeyNotUnique = "Layers with the same key are invalid";
  static const String pointKeyNotUnique = "Points with the same key are invalid";

  final Map<int, MapStackDefinition> _stacks = {};
  final MapNavigator navigator;

  final List<MapPointDefinition> mapPoints;
  final List<MapLayerDefinition> mapLayers;
  final MapKey defaultLayerKey;

  final Event<Map<int, MapStackDefinition>> mapStackChanged = Event();

  final MapVisibilityController controller = MapVisibilityController();

  int _currentStackIndex = -1;
  int get currentStackIndex => _currentStackIndex;

  MapStackDefinition get defaultStack => _getDefaultLayer(defaultLayerKey);
  Map<int, MapStackDefinition> get stacks => _stacks;

  MapImageDefinition({
    required this.navigator,
    required this.defaultLayerKey,
    this.mapPoints = const [],
    this.mapLayers = const [],
  }) {
    assert(mapLayers.isSingle((layer) => layer.key.value, defaultLayerKey.value), layerKeyNotUnique);
    assert(mapLayers.isUnique((layer) => layer.key.value), layerKeyNotUnique);
    assert(mapPoints.isUnique((point) => point.key.value), pointKeyNotUnique);

    _currentStackIndex = _getStackIndex();
    _stacks.addAll(_buildStacks(mapLayers, mapPoints));
  }

  MapStackDefinition _getDefaultLayer(MapKey key) {
    return _stacks.entries.toList().firstWhere((stack) => stack.key == key).value;
  }

  void showStack(int index) {
    _stacks.update(index, (stack) => stack.copyWith(visible: true)); 
    mapStackChanged.broadcast(_stacks);
  }

  void hideStack(int index) {
    _stacks.update(index, (stack) => stack.copyWith(visible: false)); 
    mapStackChanged.broadcast(_stacks);
  }

  void setStackIndex(int index) {
    if(_currentStackIndex != index) {
      _currentStackIndex = index;
      _stacks.clear();
      _stacks.addAll(_buildStacks(mapLayers, mapPoints));
      mapStackChanged.broadcast(_buildStacks(mapLayers, mapPoints));
    }
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

  Map<int, MapStackDefinition> _buildStacks(
    List<MapLayerDefinition> mapLayers,
    List<MapPointDefinition> mapPoints,
  ) {    
    Map<int, MapStackDefinition> stacks = {};
    mapLayers.asMap().forEach((index, layer) { 
      stacks.putIfAbsent(index, () => MapStackDefinition(
        visible: index <= _getStackIndex(),
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

