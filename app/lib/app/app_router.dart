import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'page_builder.dart';

/// Router
class AppRouter extends GoRouter {
  AppRouter({required this.builder})
      : super(
          debugLogDiagnostics: true,
          initialLocation: builder.getLandingPage().path,
          routes: _routes(builder),
        );

  final PageBuilder builder;

  // define routes
  static _routes(PageBuilder builder) {
    var routes = <GoRoute>[];

    for (var page in builder.pages) {
      routes.add(GoRoute(
        name: page.title,
        path: page.path,
        builder: (BuildContext context, GoRouterState state) {
          return builder.buildPage(page);
        },
      ));
    }

    return routes;
  }
}
