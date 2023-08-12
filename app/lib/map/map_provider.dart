import 'package:flutter/material.dart';

import '../utils/disposable.dart';

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

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.value.dispose();
    super.dispose();
  }
}