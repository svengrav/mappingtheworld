import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_definition.dart';

import '../map/map_background.dart';
import '../map/map_point_definition.dart';
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
          defaultLayer: 4,
          layers: [
            MapLayerDefinition(
                key: 1,
                label: "Voyages",
                resource: MapImageRessource(path: 'assets/maplines.png', background: Colors.black54,)),
            MapLayerDefinition(
                key: 2,
                label: "Map",
                resource: MapImageRessource(path: 'assets/image.png')),
            MapLayerDefinition(
                key: 3,
                label: "Schema",
                resource: MapImageRessource(path: 'assets/maplines.png')),
            MapLayerDefinition(
                key: 4,
                label: "Background",
                resource: MapColorResource(color: Colors.black12)),
          ],
          points: [
            MapPointDefinition(
                key: 1,
                layerKeys: [MapLayerDefinitionKey(2)],
                position: const Offset(0.5, 0.5),
                label: "Point 1",
                description:
                    "At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."),
            MapPointDefinition(
                key: 2, 
                layerKeys: [MapLayerDefinitionKey(3),MapLayerDefinitionKey(2)],
                position: const Offset(0.1, 0.5), 
                label: "Point 2"),
          ],
        ),
      );
}
