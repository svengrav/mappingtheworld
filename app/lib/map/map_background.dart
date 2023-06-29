import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Opacity(opacity: 0.8,
    child: RiveAnimation.asset('assets/background.riv', fit: BoxFit.cover));
  }
}
