import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_theme.dart';
import 'page_builder.dart';
import 'page_data.dart';

class App extends StatelessWidget {
  const App({super.key, required this.pages});

  final List<PageData> pages;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(context),
      routerConfig: AppRouter(
        builder: PageBuilder(
          pages: pages,
        ),
      ),
    );
  }
}
