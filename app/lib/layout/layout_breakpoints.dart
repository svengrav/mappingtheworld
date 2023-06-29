import 'dart:core';

import 'package:flutter/material.dart';

enum LayoutSize {
  extraSmall(lowerBound: double.minPositive, upperBound: 570),
  small(lowerBound: 571, upperBound: 770),
  medium(lowerBound: 771, upperBound: 990),
  large(lowerBound: 991, upperBound: 1200),
  extraLarge(lowerBound: 1201, upperBound: double.infinity);

  const LayoutSize({
    required this.lowerBound,
    required this.upperBound,
  });

  final double lowerBound;
  final double upperBound;

  bool fits(double value) 
    => (lowerBound < value && value < upperBound) ? true : false;

  bool operator >(LayoutSize other) {
    return lowerBound >= other.upperBound;
  }

  bool operator >=(LayoutSize other) {
    return lowerBound >= other.upperBound;
  }

  bool operator <(LayoutSize other) {
    return upperBound <= other.lowerBound;
  }

  bool operator <=(LayoutSize other) {
    return upperBound <= other.lowerBound;
  }

  bool equals(LayoutSize other) {
    return upperBound == other.upperBound && lowerBound == other.lowerBound;
  }
}


class LayoutBreakpoints {
    static LayoutSize layoutSize(BuildContext context) {
      var width = context.getScreenWidth();

      if(LayoutSize.extraSmall.fits(width)) {
        return LayoutSize.extraSmall;
      }

      if(LayoutSize.small.fits(width)) {
        return LayoutSize.small;
      }
      
      if(LayoutSize.medium.fits(width)) {
        return LayoutSize.medium;
      }

      if(LayoutSize.large.fits(width)) {
        return LayoutSize.large;
      }

      return LayoutSize.extraLarge;
    }
}

extension Layout on BuildContext {
  double getScreenWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(this).size.height -
        (MediaQuery.of(this).padding.top + kToolbarHeight);
  }

  LayoutSize getLayoutSize() {
    return LayoutBreakpoints.layoutSize(this);
  }
}
