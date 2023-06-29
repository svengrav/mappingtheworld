import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'page_data.dart';

class AppDrawer extends StatelessWidget {
  static const double width = 300;

  final List<PageData> pages;
  final PageData? activePage;

  const AppDrawer({super.key, required this.pages, this.activePage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppDrawer.width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [_DrawerTitle(), ..._buildPageTiles(context)],
      ),
    );
  }

  List<Widget> _buildPageTiles(BuildContext context) {
    var tiles = <Widget>[];
    for (var page in pages) {
      tiles.addAll(
        [
          ListTile(
            selected: page.equals(activePage),
            selectedColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.navigate_next),
            title: Text(page.title),
            onTap: () {
              context.go(page.path);
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          )
        ],
      );
    }
    return tiles;
  }
}

class _DrawerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Navigate',
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }
}
