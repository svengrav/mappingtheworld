import 'package:flutter/material.dart';

/// Abstract resource from various sources like images, SVG or Rive.
class MapResource extends StatelessWidget {
  static const MapResource empty = MapResource(source: SizedBox());

  const MapResource({super.key, required this.source, this.background});
  final Widget source;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return background != null ? Container(color: background, child: source,) : source;
  }
}

class MapImageRessource extends MapResource {
  MapImageRessource.storage({super.key, required String path, super.background})
      : super(source: Image.network(path));

  MapImageRessource({super.key, required String path, super.background})
      : super(source: Image.asset(path));
}


class MapColorResource extends MapResource {
  final Color color;

  MapColorResource({ required this.color, super.key, super.background})
      : super(source: Container(color: color));
}
