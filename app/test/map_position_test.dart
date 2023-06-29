// Import the test package and Counter class
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_position.dart';
import 'package:test/test.dart';
// ignore: avoid_relative_lib_imports

void main() {
  test('Center alignment returns valid position values', () {
    var position = MapPosition(
      alignment: Alignment.center,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 50);
    expect(position.bottom, 50);
  });

  test('Top alignment with top offset returns valid position values', () {
    var position = MapPosition(
      alignment: Alignment.topCenter,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
      top: 50
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 50);
    expect(position.bottom, 50);
  });

  test('Center alignment returns valid position values', () {
    var position = MapPosition(
      alignment: Alignment.center,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 50);
    expect(position.bottom, 50);
  });

  test('Top right alignment returns valid position values', () {
    var position = MapPosition(
      alignment: Alignment.topRight,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 100);
    expect(position.right, 0);
    expect(position.top, 0);
    expect(position.bottom, 100);
  });

  test('Top right position returns valid position values and alignment', () {
    var position = MapPosition(
      top: 0,
      right: 0,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 100);
    expect(position.right, 0);
    expect(position.top, 0);
    expect(position.bottom, 100);
  });

  test('Center position returns valid position values and center alignment', () {
    var position = MapPosition(
      top: 50,
      right: 50,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 50);
    expect(position.bottom, 50);
  });

  test('Top center position returns valid position values and top center alignment', () {
    var position = MapPosition(
      top: 0,
      right: 50,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 0);
    expect(position.bottom, 100);
  });

  test('Bottom center position returns valid position values', () {
    var position = MapPosition(
      bottom: 0,
      right: 50,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 100);
    expect(position.bottom, 0);
  });

  test('Bottom center alignment with a margin of 50 is valid', () {
    var position = MapPosition(
      bottom: 50,
      height: 100,
      width: 100,
      pageHeight: 200,
      pageWidth: 200,
      alignment: Alignment.bottomCenter
    );

    expect(position.left, 50);
    expect(position.right, 50);
    expect(position.top, 50);
    expect(position.bottom, 50);
  });
  
}
