import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_definition.dart';

import '../map/map_background.dart';
import '../map/model/map_key.dart';
import '../map/model/map_layer_definition.dart';
import '../map/model/map_point_definition.dart';
import '../map/map_resource.dart';
import '../map/map_page.dart';

class MapColumbus extends StatelessWidget {
  const MapColumbus({super.key});

  @override
  Widget build(BuildContext context) => MapPage(
        MapDefinition(
          title: "Voyages of Columbus",
          summary:
              "The four voyages of Christopher Columbus between 1492 and 1504.",
          year: "1492 - 1504",
          width: 1000,
          height: 1350,
          background: const MapBackground(),
          defaultLayerKey: const MapKey('l2'),
          layers: [
            MapLayerDefinition(
                key: const MapKey('l1'),
                label: "Voyages",
                resource: MapImageRessource(path: 'assets/maplines.png', background: Colors.black54,)),
            MapLayerDefinition(
                key: const MapKey('l2'),
                label: "Map",
                resource: MapImageRessource(path: 'assets/image.png')),
            MapLayerDefinition(
                key: const MapKey('l3'),
                label: "Schema",
                resource: MapImageRessource(path: 'assets/maplines.png', background: Colors.black26,)),
          ],
          points: [
            const MapPointDefinition(
                key: MapKey('p1'),
                layerKeys: [MapKey('l1')],
                position: Offset(0.5, 0.5),
                label: "Point 1",
                description:
                    "At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."),
            const MapPointDefinition(
                key: MapKey('p2'), 
                layerKeys: [MapKey('l1'),MapKey('l2')],
                position: Offset(0.1, 0.5), 
                label: "Point 2"),
          ],
        ),
      );
}
