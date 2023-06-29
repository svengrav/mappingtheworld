import 'package:flutter/material.dart';

class PageData {
  const PageData({
    required this.id,
    required this.title,
    required this.path,
    required this.content,
    this.landingPage = false
  });

  final String id;
  final String title;
  final String path;
  final Widget content;
  final bool landingPage;

  bool equals(PageData? page) => id == page?.id;
}