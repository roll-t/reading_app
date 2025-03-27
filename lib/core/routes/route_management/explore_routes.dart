import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/layout_shared_builder/explore/presentation/pages/explore_page.dart';
import 'package:reading_app/features/comic/di/comic_binding.dart';
import 'package:reading_app/features/comic/presentation/comic_search/page/search_comic_page.dart';
import 'package:reading_app/features/comic/presentation/comic_search/page/search_novel_page.dart';

class ExploreRoutes {
  static final routes = [
    // Explore Routes
    GetPage(
      name: Routes.explore,
      page: () => const ExplorePage(),
      binding: ComicBinding(),
    ),
    GetPage(
      name: Routes.searchComic,
      page: () => const SearchComicPage(),
      binding: ComicBinding(),
    ),
    GetPage(
      name: Routes.searchNovel,
      page: () => const SearchNovelPage(),
      binding: ComicBinding(),
    ),
  ];
}
