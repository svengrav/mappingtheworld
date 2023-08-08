
import 'package:mtw_app/map/stream/event.dart';
import 'package:mtw_app/utils/extensions.dart';

import 'model.dart';

class MapImageDefinition {  
  static const String layerKeyNotUnique = "Layers with the same key are invalid";
  static const String pointKeyNotUnique = "Points with the same key are invalid";

  final MapNavigator navigator;

  final List<MapPointDefinition> mapPoints;
  final List<MapLayerDefinition> mapLayers;
  final MapKey defaultLayerKey;

  final Event<Map<int, MapStackDefinition>> mapStackChanged = Event();

  Map<int, MapStackDefinition> _stacks = {};
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
    _stacks = _buildStacks(mapLayers, mapPoints);
  }

  MapStackDefinition _getDefaultLayer(MapKey key) {
    return _stacks.entries.toList().firstWhere((stack) => stack.key == key).value;
  }

  void setStackIndex(int index) {
    if(_currentStackIndex != index) {
      _currentStackIndex = index;
      _stacks = _buildStacks(mapLayers, mapPoints);
      mapStackChanged.broadcast(_stacks);
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
