
import 'package:flutter/material.dart';
import 'package:mtw_app/map/model/map_point_definition.dart';

class MapImagePointContent extends StatelessWidget {
  const MapImagePointContent({
    super.key,
    required MapPointDefinition pointDefinition,
    required this.dialogSize,
  }) : _pointDefinition = pointDefinition;

  final MapPointDefinition _pointDefinition;
  final EdgeInsets dialogSize;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: const RoundedRectangleBorder(),
        titlePadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_pointDefinition.label,
                style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
              visualDensity: VisualDensity.comfortable,
            )
          ],
        ),
        insetPadding: dialogSize,
        children: [
          Text(
            _pointDefinition.description ?? "",
          )
        ]);
  }
}
