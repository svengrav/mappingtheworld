import 'package:flutter/material.dart';
import 'package:mtw_app/content/columbus.dart';
import 'package:mtw_app/content/project.dart';

import 'app/app.dart';
import 'app/page_data.dart';
import 'content/blaeu.dart';

void main() {
  runApp(
    const App(
      pages: [
        PageData(
          id: "home",
          title: "Mapping the World",
          path: "/",
          content: Project(),
        ),
        PageData(
          id: "columbus",
          title: "Columbus",
          path: "/columbus",
          landingPage: true,
          content: MapColumbus(),
        ),
        PageData(
          id: "blaeu",
          title: "Blaeu",
          path: "/blaeu",
          landingPage: false,
          content: MapBlaeu(),
        ),
      ],
    ),
  );
}
