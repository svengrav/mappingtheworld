import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/export.dart';
import 'package:mtw_app/map/model/map_key.dart';
import 'package:mtw_app/map/model/map_layer_definition.dart';

import '../map/map_background.dart';
import '../map/map_page.dart';
import '../map/map_resource.dart';
import '../map/model/map_definition.dart';

class MapBlaeu extends StatelessWidget {
  const MapBlaeu({super.key});

  @override
  Widget build(BuildContext context) => MapPage(
        MapDefinition(
          title: "Chart of the World",
          summary: "Chart of the world by Willem and Joan Blaeu.",
          year: "1630 & 1665",
          width: 3600,
          height: 2400,
          defaultLayerKey: const MapKey(0),
          background: const MapBackground(),
          points: const [
             MapPointDefinition(
              key: MapKey('p1'),
              position: Offset(0.5, 0.5),
              label: 'Point 1',
              description: 'Mein Point 1',
              layerKeys: [MapKey(0)]
            )
          ],
          layers: [
            MapLayerDefinition(
              key: const MapKey(0),
              label: 'Blaeu',
              resource: MapImageRessource.storage(
                  path:
                      'https://stmtwcore.blob.core.windows.net/app-images/map-bleau.jpg?sp=r&st=2023-08-09T14:19:40Z&se=2023-08-09T22:19:40Z&spr=https&sv=2022-11-02&sr=b&sig=Abq7irHtkevqdV4gyiEYFTEeBpeYodzB1eFzH9DD%2FBI%3D'),
            ),
            MapLayerDefinition(
              key: const MapKey(1),
              label: '',
              resource: MapColorResource(
                color: Colors.black12,
              ),
            ),
            MapLayerDefinition(
              key: const MapKey(2),
              label: '',
              resource: MapColorResource(
                color: const Color.fromARGB(31, 74, 87, 165),
              ),
            ),
          ],
        ),
      );
}
