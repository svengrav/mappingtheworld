
import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_definition.dart';
import 'package:mtw_app/map/map_stack_slider.dart';

import '../utils/disposable.dart';

class MapContent extends StatelessWidget {
  final MapDefinition map;
  final Widget child;
  const MapContent({super.key, required this.map, required this.child,});

  @override
  Widget build(BuildContext context) {
    return MapProvider<MapDefinition>(create:  map, child: child);
  }
}

class MapProvider<T extends Disposable> extends StatefulWidget {
  final Widget child;
  final T value;

  const MapProvider({
    Key? key,
    required T create,
    required this.child,
  })  : value = create, super(key: key);

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

