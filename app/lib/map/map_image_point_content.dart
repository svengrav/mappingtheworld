import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_point_definition.dart';

class MapImagePointContent extends StatelessWidget {
  const MapImagePointContent({
    super.key,
    required this.pointDefinition,
    required this.dialogSize,
  });

  final MapPointDefinition pointDefinition;
  final EdgeInsets dialogSize;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: const RoundedRectangleBorder(),
        titlePadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        title: _PointTitle(pointDefinition: pointDefinition),
        insetPadding: dialogSize,
        children: [Text(pointDefinition.description ?? "")]);
  }
}

class _PointTitle extends StatelessWidget {
  const _PointTitle({
    required this.pointDefinition,
  });

  final MapPointDefinition pointDefinition;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(pointDefinition.label,
            style: Theme.of(context).textTheme.titleMedium),
        IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            visualDensity: VisualDensity.comfortable)
      ],
    );
  }
}
