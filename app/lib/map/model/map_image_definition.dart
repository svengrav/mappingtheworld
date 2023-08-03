
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

  final List<MapStackDefinition> _stacks = [];
  final MapNavigator navigator;

  final List<MapPointDefinition> mapPoints;
  final List<MapLayerDefinition> mapLayers;
  final MapKey defaultLayerKey;

  final MapVisibilityController controller = MapVisibilityController();

  int _currentStackIndex = -1;
  int get currentStackIndex => _currentStackIndex;

  MapStackDefinition get defaultStack => _getDefaultLayer(defaultLayerKey);
  List<MapStackDefinition> get stacks => _stacks;

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
    return _stacks.firstWhere((stack) => stack.key == key);
  }

  void setStackIndex(int index) {
    _currentStackIndex = index;
    _stacks.clear();
    _stacks.addAll(_buildStacks(mapLayers, mapPoints));
    controller.notify(this);
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

  List<MapStackDefinition> _buildStacks(
    List<MapLayerDefinition> mapLayers,
    List<MapPointDefinition> mapPoints,
  ) {    
    List<MapStackDefinition> stacks = [];
    mapLayers.asMap().forEach((index, layer) { 
      stacks.add(MapStackDefinition(
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
