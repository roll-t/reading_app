import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/category/di/category_binding.dart';
import 'package:reading_app/features/category/presentation/comic/pages/category_comic_page.dart';
import 'package:reading_app/features/comic/di/comic_binding.dart';
import 'package:reading_app/features/comic/presentation/comic_detail/pages/comic_detail_page.dart';
import 'package:reading_app/features/comic/presentation/comic_read/pages/read_comic_page.dart';

class ComicRoutes {
  static final routes = [
    // Comic Routes
    GetPage(
      name: Routes.comicDetail,
      page: () => const ComicDetailPage(),
      binding: ComicBinding(),
    ),
    GetPage(
      name: Routes.readBook,
      page: () => const ReadComicPage(),
      binding: ComicBinding(),
    ),
    GetPage(
      name: Routes.category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
  ];
}
