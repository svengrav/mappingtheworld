import 'package:mtw_app/map/map_background.dart';
import 'package:mtw_app/map/model/map_navigator.dart';
import 'package:mtw_app/map/model/map_point_definition.dart';

import '../../utils/disposable.dart';
import 'map_image_definition.dart';
import 'map_key.dart';
import 'map_layer_definition.dart';

class MapDefinition implements Disposable {
  final double width;
  final double height;
  final String title;
  final String year;
  final String summary;
  final MapImageDefinition image;
  final MapBackground? background;

  MapNavigator get navigator => image.navigator;

  MapDefinition({
    required this.width,
    required this.height,
    required this.title,
    required this.year,
    required this.summary,
    required MapKey defaultLayerKey,
    this.background,
    List<MapPointDefinition> points = const [],
    List<MapLayerDefinition> layers = const [],
  }) : image = MapImageDefinition(
          defaultLayerKey: defaultLayerKey,
          mapLayers: layers.reversed.toList(),
          mapPoints: points.reversed.toList(),
          navigator: MapNavigator(mapWidth: width, mapHeight: height),
        );
        
  @override
  void dispose() {
  }

  @override
  String toString() {
    return 'width: $width - height: $height - title: $title - year: $year';
  }
}
