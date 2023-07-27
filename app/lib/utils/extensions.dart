import 'dart:math';
import 'package:flutter/material.dart';

extension Position on TransformationController {
  double getXOffset() => value.entry(0, 3);
  double getYOffset() => value.entry(1, 3);
  double getScale() => value.getMaxScaleOnAxis();
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).truncateToDouble() / mod);
  }
}

extension Screen on BuildContext {
  double getScreenWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(this).size.height -
        (MediaQuery.of(this).padding.top + kToolbarHeight);
  }
}

extension IterableExtension<T> on Iterable<T> {
  bool isUnique(Object Function(T e) getValue) {
    bool isUnique = true;
    forEach((element) {
      if (where((otherElement) => getValue(otherElement) == getValue(element)).length > 1) {
        isUnique = false;
      }
    });
    return isUnique;
  }
  
  bool isSingle(Object Function(T e) getValue, Object value) 
    => where((element) => getValue(element) == value).length == 1;
}
