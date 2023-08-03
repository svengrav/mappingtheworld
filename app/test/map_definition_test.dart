import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_key.dart';
import 'package:mtw_app/map/model/map_navigator.dart';
import 'package:mtw_app/map/model/map_image_definition.dart';
import 'package:mtw_app/map/model/map_layer_definition.dart';
import 'package:mtw_app/map/model/map_point_definition.dart';
import 'package:mtw_app/map/map_resource.dart';
import 'package:test/test.dart';

// ignore: avoid_relative_lib_imports
void main() {
  test('Stack definition returns valid default stack', () {
    var stackDefinition = MapImageDefinition(
      navigator: MapNavigator(mapWidth: 100, mapHeight: 100),
      defaultLayerKey: const MapKey(1),
      mapPoints: [
        const MapPointDefinition(
          key: MapKey(1),
          position: Offset.zero,
          label: "label1",
          layerKeys: [
            MapKey(1),
          ],
        )
      ],
      mapLayers: [
        const MapLayerDefinition(
          key: MapKey(1),
          label: "label1",
          resource: MapResource.empty,
        ),
        const MapLayerDefinition(
          key: MapKey(2),
          label: "label2",
          resource: MapResource.empty,
        )
      ],
    );

    expect(stackDefinition.defaultStack.key.value, "key2");
  });

  test('Stack definition returns valid default stack 2', () {
    expect(
        () => MapImageDefinition(
          navigator: MapNavigator(mapWidth: 100, mapHeight: 100),
          defaultLayerKey: const MapKey(1), 
          mapLayers: [
              const MapLayerDefinition(
                  key: MapKey(1), label: "label1", resource: MapResource.empty),
              const MapLayerDefinition(
                  key: MapKey(2), label: "label2", resource: MapResource.empty),
              const MapLayerDefinition(
                  key: MapKey(3), label: "label2", resource: MapResource.empty)
            ]),
        throwsA(predicate((error) =>
            error is AssertionError &&
            error.message == MapImageDefinition.layerKeyNotUnique)));
  });
}
