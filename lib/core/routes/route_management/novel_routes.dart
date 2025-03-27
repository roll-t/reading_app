import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/comic/di/comic_binding.dart';
import 'package:reading_app/features/novel/di/novel_binding.dart';
import 'package:reading_app/features/novel/presentation/novel_category/page/category_novel_page.dart';
import 'package:reading_app/features/novel/presentation/novel_detail/pages/novel_detail_page.dart';
import 'package:reading_app/features/novel/presentation/novel_read/pages/read_novel_page.dart';

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
      binding: ComicBinding(),
    ),
  ];
}
