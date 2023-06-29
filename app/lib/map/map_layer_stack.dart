import 'package:flutter/material.dart';
import 'package:mtw_app/utils/notifier.dart';

class MapLayerStackController with Notifier {
  MapLayerStackController({visibile = true});
  bool visible = true;
}

class MapLayerStack extends StatefulWidget {
  MapLayerStack({super.key, required this.elements});

  final MapLayerStackController controller = MapLayerStackController();
  final List<Widget> elements;

  bool isVisible() => controller.visible;

  void show() {
    if (!controller.visible) {
      controller.visible = true;
      controller.notify(this);
    }
  }

  void hide() {
    if (controller.visible) {
      controller.visible = false;
      controller.notify(this);
    }
  }

  @override
  State<MapLayerStack> createState() => _MapLayerStackState();
}

class _MapLayerStackState extends State<MapLayerStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    value: 1.0,
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  void _addListener() {
    widget.controller.addListener(NotifierListener((sender, args) {
      _setVisibility();
    }));
  }

  void _setVisibility() {
    if (widget.isVisible()) {
      setState(() {
        _controller.animateTo(1.0);
      });
    } else {
      setState(() {
        _controller.animateTo(0.0);
      });
    }
  }

  @override
  void didUpdateWidget(MapLayerStack mapStack) {
    super.didUpdateWidget(mapStack);
    _addListener();
  }

  @override
  void initState() {
    super.initState();
    _addListener();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: widget.elements,
      ),
    );
  }
}
