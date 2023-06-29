import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_card.dart';

import '../app/app_theme.dart';
import '../utils/notifier.dart';
import 'map_position.dart';

class MapSettingsSwitch extends StatefulWidget {
  const MapSettingsSwitch({super.key, required this.controller});

  final MapPositionController controller;

  @override
  State<MapSettingsSwitch> createState() => _MapSettingsSwitchState();
}

class _MapSettingsSwitchState extends State<MapSettingsSwitch> {
  var visible = false;

  @override
  initState() {
    super.initState();
    widget.controller
        .addListener(ValueListener<dynamic, bool>((sender, args) => {
              setState(
                () {
                  visible = args?.value ?? false;
                },
              )
            }));
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.close);
      }
      return const Icon(Icons.open_in_full);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        activeColor: AppTheme.primaryColor,
        trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
        trackColor: const MaterialStatePropertyAll(Colors.white10),
        value: visible,
        thumbIcon: thumbIcon,
        onChanged: (bool value) {
          // This is called when the user toggles the switch.
          setState(() {
            widget.controller.visible
                ? widget.controller.hide()
                : widget.controller.show();

            visible = widget.controller.visible;
          });
        },
      ),
    );
  }
}



class MapSettings extends StatefulWidget {
  MapSettings({
    key,
    required this.settings,
    required this.position,
  }) : super(key: key ?? UniqueKey());

  final List<Widget> settings;
  final MapPosition position;

  @override
  State<MapSettings> createState() => _MapSettingsState();
}

class _MapSettingsState extends State<MapSettings> {
  late MapPositionController _controller;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.close);
      }
      return const Icon(Icons.open_in_full);
    },
  );

  @override
  void initState() {
    super.initState();
    _controller = widget.position.controller;
    _controller.addListener(
        ValueListener((sender, args) => { setState(() {}) }));
  }

  @override
  Widget build(BuildContext context) {
    return widget.position.build(MapCard(
            label: 'Settings',
            onClose: () => _controller.hide(),
            child: Column(children: widget.settings),
          ));
  }
}

class TextIcon extends StatelessWidget {
  const TextIcon({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
  });

  final IconData icon;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    var iconSize = textStyle?.fontSize;

    return Row(
      children: [
        Icon(icon, size: iconSize),
        const SizedBox(width: 4),
        Text(text, style: textStyle),
      ],
    );
  }
}
