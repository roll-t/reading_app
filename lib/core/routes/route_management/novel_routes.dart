import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/content/book_details/novel_detail/di/novel_binding.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/page/novel_detail_page.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/page/read_novel_page.dart';
import 'package:reading_app/features/content/categories/comics/di/category_binding.dart';
import 'package:reading_app/features/content/categories/novels/presentation/page/category_novel_page.dart';

class NovelRoutes {
  static final routes = [
    // Novel Routes
    GetPage(
      name: Routes.novelDetail,
      page: () => const NovelDetailPage(),
      binding: NovelBinding(),
    ),
    GetPage(
      name: Routes.readNovel,
      page: () => const ReadNovelPage(),
      binding: NovelBinding(),
    ),
    GetPage(
      name: Routes.categoryNovel,
      page: () => const CategoryNovelPage(),
      binding: CategoryBinding(),
    ),
  ];
}
