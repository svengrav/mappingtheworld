// Import the test package and Counter class
import 'package:flutter/material.dart';
import 'package:mtw_app/app/page_builder.dart';
import 'package:mtw_app/app/page_data.dart';
import 'package:test/test.dart';
// ignore: avoid_relative_lib_imports

void main() {

  test('Two pages with the different ID are valid', () {
    var pages = <PageData>[
      const PageData(
          id: '1', title: 'page 1', path: '/page1', content: Placeholder(), landingPage: true),
      const PageData(
          id: '2', title: 'page 2', path: '/page2', content: Placeholder()),
    ];

    expect(PageBuilder(pages: pages).pages.length, 2);
  });

  test('Two or more pages with the same ID are invalid', () {
    var pages = <PageData>[
      const PageData(
          id: '1', title: 'page 1', path: '/page1', content: Placeholder(), landingPage: true),
      const PageData(
          id: '1', title: 'page 2', path: '/page2', content: Placeholder()),
    ];

    expect(
      () => PageBuilder(pages: pages),
      throwsA(predicate((error) =>
          error is AssertionError &&
          error.message == 'Two or more pages with the same ID are invalid')),
    );
  });
  
  test('A unique landing page is required', () {
    var pages = <PageData>[
      const PageData(
          id: '1', title: 'page 1', path: '/page1', content: Placeholder()),
      const PageData(
          id: '2', title: 'page 2', path: '/page2', content: Placeholder()),
    ];

    expect(
      () => PageBuilder(pages: pages),
      throwsA(predicate((error) =>
          error is AssertionError &&
          error.message == 'Unique landing page is required')),
    );
  });
}
