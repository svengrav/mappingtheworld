import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_definition.dart';
import 'package:mtw_app/map/map_position.dart';
import 'package:mtw_app/map/map_settings.dart';
import 'package:mtw_app/utils/extensions.dart';

import '../app/app_scaffold.dart';
import 'map_description.dart';
import 'map_image.dart';
import 'map_stack_slider.dart';
import 'map_navigator_card.dart';
import 'map_navigator_settings.dart';

class MapPage extends StatelessWidget {

  static const double padding = 10;
  final MapDefinition definition;

  const MapPage(
    this.definition, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var pageHeight = context.getScreenHeight() - (padding * 2);
    var pageWidth = context.getScreenWidth() - (padding * 2);

    var controller = TransformationController();
    var navigator = definition.navigator.set(pageWidth: pageWidth, pageHeight: pageHeight);

    var navigatorController = MapNavigatorCardController(navigator: navigator);

    var mapSliderPosition = MapPosition(
      pageWidth: pageWidth,
      pageHeight: pageHeight,
      height: 60,
      width: 300,
      alignment: Alignment.bottomCenter,
    );

    var mapNavigatorPosition = MapPosition(
        pageWidth: pageWidth,
        pageHeight: pageHeight,
        height: 400,
        width: 400,
        alignment: Alignment.topRight,
        controller: navigatorController,
    );

    var mapTitlePositon = MapPosition(
      pageWidth: pageWidth,
      pageHeight: pageHeight,
      height: 200,
      width: 400,
      alignment: Alignment.topLeft,
    );

    var mapSettingsPosition = MapPosition(
      pageWidth: pageWidth,
      pageHeight: pageHeight,
      visible: false,
      height: 300,
      width: 400,
      alignment: Alignment.topCenter,
    );

    navigator.shrinkPage(height: mapSliderPosition.height);

    if (navigator.position.right < mapNavigatorPosition.width) {
      mapNavigatorPosition.controller.hide();
    }

    if (navigator.position.left < mapTitlePositon.width) {
      mapTitlePositon.set(
          alignment: Alignment.topCenter,
          alignChild: Alignment.center,
          height: 100);
      navigator.set(
          shrinkHeight: mapTitlePositon.height + mapSliderPosition.height,
          top: mapTitlePositon.height);
    }

    AppScaffold.of(context).setActions(
        [MapSettingsSwitch(controller: mapSettingsPosition.controller)]);

    return _MapPageContent(
      children: [
        definition.background ?? const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(children: [
            MapImage(
              controller: controller,
              navigator: navigator,
              stack: definition.image,
              position: navigator.position,
            ),
            MapDescription(
              definition: definition,
              position: mapTitlePositon,
            ),
            MapStackSlider(
              position: mapSliderPosition,
              image: definition.image,
            ),
            MapNavigatorCard(
              controller: navigatorController,
              position: mapNavigatorPosition,
              navigator: navigator,
            ),
            MapSettings(
              position: mapSettingsPosition,
              settings: [
                MapNavigatorSettings(
                  controller: navigatorController,
                )
              ],
            )
          ]),
        )
      ],
    );
  }

  static MapPage? maybeOf(BuildContext context) {
    return context.findAncestorWidgetOfExactType<MapPage>();
  }

  static MapPage of(BuildContext context) {
    final MapPage? result = maybeOf(context);
    assert(result != null, 'MapPage not found.');
    return result!;
  }
}

class _MapPageContent extends StatelessWidget {
  const _MapPageContent({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: children,
      ),
    );
  }
}
