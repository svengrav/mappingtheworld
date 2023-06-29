import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_definition.dart';

import '../map/map_background.dart';
import '../map/map_layer.dart';
import '../map/map_layer_point.dart';
import '../map/map_resource.dart';
import '../map/map_page.dart';

class MapColumbus extends StatelessWidget {
  const MapColumbus({super.key});

  @override
  Widget build(BuildContext context) => MapPage(
        definition: MapDefinition(
          title: "Voyages of Columbus",
          summary: "The four voyages of Christopher Columbus between 1492 and 1504.",
          year: "1492 - 1504",
          width: 1000,
          height: 1350, 
        ),
        defaultLayer: 0,
        background: const MapBackground(),
        points: const [
          MapPoint(
            offset: FractionalOffset(0.5, 0.5),
            layer: [0, 1, 3],
          ),
          MapPoint(
            offset: FractionalOffset(0, 0),
            layer: [1],
          ),
        ],
        layers: [
          MapLayer(
            resource: MapColorResource(color: Colors.black12,),
          ),
          MapLayer(
            resource: MapImageRessource(path: 'assets/maplines.png'),
          ),
          MapLayer(
            resource: MapImageRessource(path: 'assets/image.png'),
          ),
          MapLayer(
            resource: MapImageRessource(path: 'assets/line.png'),
          ),
        ],
      );
}
