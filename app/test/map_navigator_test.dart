// Import the test package and Counter class

import 'package:mtw_app/map/model/map_navigator.dart';
import 'package:mtw_app/utils/notifier.dart';
import 'package:test/test.dart';

// ignore: avoid_relative_lib_imports
void main() {
  test('Shrink map height by 70 is width 60 and height 90', () {
    const pageWidth = 100.0;
    const pageHeight = 160.0;
    const mapWidth = 80.0;
    const mapHeight = 120.0;
    const shrinkHeight = 70.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );
    mapNavigator.shrinkPage(height: shrinkHeight);

    expect(mapNavigator.position.width, 60);
    expect(mapNavigator.position.height, 90);
    expect(mapNavigator.mapCurrentWidth, 60);
    expect(mapNavigator.mapCurrentHeight, 90);
  });

  test('Map max scale is limited by page', () {
    const pageWidth = 100.0;
    const pageHeight = 160.0;
    const mapWidth = 100.0;
    const mapHeight = 100.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );

    expect(mapNavigator.mapMaxScale, 1);
    expect(mapNavigator.mapCurrentWidth, 100);
    expect(mapNavigator.mapCurrentHeight, 100);
  });

  test('Map max scale is limited by map height', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 100.0;
    const mapHeight = 150.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );

    expect(mapNavigator.mapMaxScale, 1.5);
  });

  test('Map size is limited by page height', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 100.0;
    const mapHeight = 200.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );

    expect(mapNavigator.mapCurrentWidth.toInt(), 50);
    expect(mapNavigator.mapCurrentHeight.toInt(), 100);
  });

  test('Map size is limited by page width', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 200.0;
    const mapHeight = 100.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );

    expect(mapNavigator.mapCurrentWidth.toInt(), 100);
    expect(mapNavigator.mapCurrentHeight.toInt(), 50);
  });

  test('Map size is limited by page height and width', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 200.0;
    const mapHeight = 400.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );

    expect(mapNavigator.mapCurrentWidth.toInt(), 50);
    expect(mapNavigator.mapCurrentHeight.toInt(), 100);
  });

  test('Map size is not shrinked cause map less than page size', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 50.0;
    const mapHeight = 50.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );

    expect(mapNavigator.mapCurrentWidth.toInt(), 50);
    expect(mapNavigator.mapCurrentHeight.toInt(), 50);
  });

  test('Map size of 100 is scaled by 2x to 200', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 100.0;
    const mapHeight = 100.0;
    const scale = 2.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );
    mapNavigator.set(mapScale: scale);

    expect(mapNavigator.mapCurrentWidth.toInt(), 200);
    expect(mapNavigator.mapCurrentHeight.toInt(), 200);
  });

  test('Pixel position on the map is calculated correctly without scale', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 100.0;
    const mapHeight = 100.0;
    const scale = 1.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );
    mapNavigator.set(mapScale: scale);

    var xpos = mapNavigator.calcPixelXPosition(0);
    var ypos = mapNavigator.calcPixelYPosition(0);

    expect(xpos, 0);
    expect(ypos, 0);
  });

  test('Pixel position on the map is calculated correctly with scale', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 100.0;
    const mapHeight = 100.0;
    const scale = 2.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );
    mapNavigator.set(mapScale: scale);

    var xpos = mapNavigator.calcPixelXPosition(0.5);
    var ypos = mapNavigator.calcPixelYPosition(0.2);

    expect(xpos, 100);
    expect(ypos, 40);
  });

  test('Relative position on the map is calculated correctly', () {
    const pageWidth = 100.0;
    const pageHeight = 100.0;
    const mapWidth = 100.0;
    const mapHeight = 100.0;
    const scale = 2.0;

    final mapNavigator = MapNavigator(
      mapWidth: mapWidth,
      mapHeight: mapHeight,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
    );
    mapNavigator.set(mapScale: scale);

    var xpos = mapNavigator.calcRelativeXPosition(50);
    var ypos = mapNavigator.calcRelativeYPosition(40);

    expect(xpos, 0.25);
    expect(ypos, 0.2);
  });

  test('Value change notifies listeners', () {
    bool isNotified = false;

    final mapNavigator = MapNavigator(
        mapWidth: 100, mapHeight: 100, pageWidth: 100, pageHeight: 100);

    mapNavigator
        .addListener(NotifierListener((obj, args) => isNotified = true));

    expect(isNotified, false);
    mapNavigator.set(
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(isNotified, true);
  });

  test('No value change does not notifies listeners', () {
    bool isNotified = false;

    final mapNavigator = MapNavigator(
        mapWidth: 100, mapHeight: 100, pageWidth: 100, pageHeight: 100);

    mapNavigator.addListener(NotifierListener((obj, args) => isNotified = true));
    expect(isNotified, false);

    // set height and width to same value
    mapNavigator.set(
      pageHeight: 100,
      pageWidth: 100,
    );

    expect(isNotified, false);
  });
}
