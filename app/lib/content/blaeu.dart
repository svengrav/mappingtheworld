import 'package:flutter/material.dart';
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
          points: const [],
          layers: [
            MapLayerDefinition(
              key: const MapKey(0),
              label: '',
              resource: MapColorResource(
                color: Colors.black12,
              ),
            ),
            MapLayerDefinition(
              key: const MapKey(1),
              label: '',
              resource: MapColorResource(
                color: const Color.fromARGB(31, 74, 87, 165),
              ),
            ),
          ],
        ),
      );
}
