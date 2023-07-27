import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_point_definition.dart';
import 'package:mtw_app/map/map_resource.dart';
import 'package:test/test.dart';

// ignore: avoid_relative_lib_imports
void main() {
  test('Stack definition returns valid default stack', () {
    var stackDefinition = MapStackDefinition(
      defaultLayerKey: "key2",
      mapPoints: [
        MapPointDefinition(
          key: "key1",
          position: Offset.zero,
          label: "label1",
          layerKeys: [
            MapLayerDefinitionKey('key1'),
          ],
        )
      ],
      mapLayers: [
        MapLayerDefinition(
          key: "key1",
          label: "label1",
          resource: MapResource.empty,
        ),
        MapLayerDefinition(
          key: "key2",
          label: "label2",
          resource: MapResource.empty,
        )
      ],
    );

    expect(stackDefinition.defaultStack.key.value, "key2");
  });

  test('Stack definition returns valid default stack 2', () {
    expect(
        () => MapStackDefinition(defaultLayerKey: "key1", mapLayers: [
              MapLayerDefinition(
                  key: "key1", label: "label1", resource: MapResource.empty),
              MapLayerDefinition(
                  key: "key2", label: "label2", resource: MapResource.empty),
              MapLayerDefinition(
                  key: "key2", label: "label2", resource: MapResource.empty)
            ]),
        throwsA(predicate((error) =>
            error is AssertionError &&
            error.message == MapStackDefinition.layerKeyNotUnique)));
  });
}
