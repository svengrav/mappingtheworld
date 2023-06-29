import 'package:flutter/material.dart';
import 'map_navigator_card.dart';

class MapNavigatorSettings extends StatefulWidget {
  const MapNavigatorSettings({super.key, required this.controller});

  final MapNavigatorCardController controller;

  @override
  State<MapNavigatorSettings> createState() => _MapNavigatorSettingsState();
}

class _MapNavigatorSettingsState extends State<MapNavigatorSettings> {
  @override
  Widget build(BuildContext context) {
    var isChecked = widget.controller.visible;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.near_me, size: 18),
            SizedBox(width: 10),
            Text('Navigator'),
          ],
        ),
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              widget.controller.visible
                  ? widget.controller.hide()
                  : widget.controller.show();
              isChecked = value!;
            });
          },
        )
      ],
    );
  }
}
