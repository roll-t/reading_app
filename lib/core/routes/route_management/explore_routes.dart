import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/content/explores/di/explore_binding.dart';
import 'package:reading_app/features/content/explores/presentation/page/explore_page.dart';
import 'package:reading_app/features/content/searches/di/search_binding.dart';
import 'package:reading_app/features/content/searches/presentation/page/search_comic_page.dart';
import 'package:reading_app/features/content/searches/presentation/page/search_novel_page.dart';

class ExploreRoutes {
  static final routes = [
    // Explore Routes
    GetPage(
      name: Routes.explore,
      page: () => const SearchBookPage(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: Routes.searchComic,
      page: () => const SearchComicPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.searchNovel,
      page: () => const SearchNovelPage(),
      binding: SearchBinding(),
    ),
  ];
}
