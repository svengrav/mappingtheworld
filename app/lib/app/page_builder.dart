import 'package:mtw_app/utils/extensions.dart';

import 'app_drawer.dart';
import 'page.dart';
import 'page_data.dart';

class PageBuilder {
  final List<PageData> pages;

  PageBuilder({required this.pages}) {
    assert(containsUniqueLandingPage(), 'Unique landing page is required');
    assert(pageIdsAreUnique(),'Two or more pages with the same ID are invalid');
  }

  AppDrawer buildDrawer() => AppDrawer(pages: pages);

  Page buildPage(PageData pageData) => Page(
        id: pageData.id,
        title: pageData.title,
        path: pageData.path,
        drawer: buildDrawer(),
        child: pageData.content,
      );

  List<Page> buildPages() {
    var buildPages = <Page>[];
    for (var pageData in pages) {
      buildPages.add(buildPage(pageData));
    }
    return buildPages;
  }

  bool containsUniqueLandingPage() =>
      pages.where((page) => page.landingPage).length == 1;

  PageData getLandingPage() => pages.firstWhere((page) => page.landingPage);
  bool pageIdsAreUnique() => pages.isUniqueValue((page) => page.id);
}
