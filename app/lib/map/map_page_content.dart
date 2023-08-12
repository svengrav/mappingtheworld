
import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_definition.dart';

import 'map_provider.dart';

class MapPageContent extends StatelessWidget {
  static const double padding = 10;

  final MapDefinition map;
  final List<Widget> children;
  const MapPageContent({super.key, required this.map, required this.children,});

  @override
  Widget build(BuildContext context) {
    return MapProvider<MapDefinition>(create: map, child: 
    
    Stack(
      children: [
        map.background ?? const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(children: children),
        )
      ],
    )
  
    );
  }
}