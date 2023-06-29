import 'package:flutter/material.dart';
import 'package:mtw_app/app/app_drawer.dart';

import 'app_scaffold.dart';

class Page extends StatelessWidget {
  final Widget child;

  final AppDrawer drawer;
  final String id;
  final String path;
  final String title;

  const Page({
    super.key,
    required this.id,
    required this.title,
    required this.path,
    required this.child,
    required this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(drawer: drawer, child: child);
  }
}
