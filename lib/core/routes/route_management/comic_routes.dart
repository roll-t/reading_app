import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/content/book_details/comics/comic_detail/di/comic_detail_binding.dart';
import 'package:reading_app/features/content/book_details/comics/comic_detail/presentation/pages/comic_detail_page.dart';
import 'package:reading_app/features/content/book_details/comics/comic_read/di/read_comic_binding.dart';
import 'package:reading_app/features/content/book_details/comics/comic_read/presentation/pages/read_comic_page.dart';
import 'package:reading_app/features/content/categories/comics/di/category_binding.dart';
import 'package:reading_app/features/content/categories/comics/presentation/pages/category_comic_page.dart';

class ComicRoutes {
  static final routes = [
    // Comic Routes
    GetPage(
      name: Routes.comicDetail,
      page: () => const ComicDetailPage(),
      binding: ComicDetailBinding(),
    ),
    GetPage(
      name: Routes.readBook,
      page: () => const ReadComicPage(),
      binding: ReadComicBinding(),
    ),
    GetPage(
      name: Routes.category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
  ];
}
