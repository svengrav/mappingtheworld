
import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_definition.dart';

class MapContent extends StatelessWidget {
  final MapDefinition map;
  const MapContent({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return MapProvider<MapDefinition>(create:  map, child: SizedBox());
  }
}

abstract class Disposable {
  void dispose();
}

class MapProvider<T extends Disposable> extends StatefulWidget {
  final Widget child;
  final T value;

  const MapProvider({
    Key? key,
    required T create,
    required this.child,
  })  : value = create, super(key: key);

  // 2
  static T of<T extends Disposable>(BuildContext context) {
    final MapProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.value;
  }

  @override
  State createState() => _MapProviderState();
}

class _MapProviderState extends State<MapProvider> {
  // 3
  @override
  Widget build(BuildContext context) => widget.child;

  // 4
  @override
  void dispose() {
    widget.value.dispose();
    super.dispose();
  }
}

