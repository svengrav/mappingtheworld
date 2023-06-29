import 'package:flutter/material.dart';

import '../utils/notifier.dart';
import 'map_card.dart';
import 'map_navigator.dart';
import 'map_position.dart';

class MapNavigatorCard extends StatefulWidget {
  static const double width = 300;

  MapNavigatorCard({
    key,
    required this.navigator,
    required this.controller,
    required this.position,
  }) : super(key: key ?? UniqueKey());

  final MapNavigator navigator;
  final MapNavigatorCardController controller;
  final MapPosition position;

  @override
  State<MapNavigatorCard> createState() => _MapNavigatorCard();
}

class _MapNavigatorCard extends State<MapNavigatorCard> {
  late MapPositionController _controller;
  late MapNavigator _navigator;

  Map<String, String> _mapNavigatorSet = {};

  @override
  void initState() {
    super.initState();
    _controller = widget.position.controller;
    _navigator = widget.navigator;

    _controller.addListener(
        ValueListener((sender, args) => { setState(() {}) }));
    _navigator.addListener(
        ValueListener((sender, args) => { setState(() {}) }));

    _mapNavigatorSet = _navigator.toDictionary();
  }

  List<TableRow> buildNavigatorTable() {
    var rows = <TableRow>[];
    for (var entry in _mapNavigatorSet.entries) {
      rows.add(TableRow(children: [
        TableCell(child: Text(entry.key)),
        TableCell(child: Text(entry.value))
      ]));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    var content = Table(columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(1)
      },
      children: buildNavigatorTable(),
    );

    return widget.position.build(MapCard(
      label: 'Navigator',
      onClose: () => _controller.hide(),
      child: content,
    ));
  }
}

class MapNavigatorCardController extends MapPositionController {
  final MapNavigator navigator; 

  MapNavigatorCardController({required this.navigator, super.visible = true}) {
    navigator.addListener(ValueListener((sender, args) => { super.notify(sender) }));
  }
}
