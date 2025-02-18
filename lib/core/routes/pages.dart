import 'package:get/get.dart';
import 'package:reading_app/core/routes/route_management/auth_routes.dart';
import 'package:reading_app/core/routes/route_management/comic_routes.dart';
import 'package:reading_app/core/routes/route_management/comment_routes.dart';
import 'package:reading_app/core/routes/route_management/explore_routes.dart';
import 'package:reading_app/core/routes/route_management/novel_routes.dart';
import 'package:reading_app/core/routes/route_management/profile_routes.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/main/di/main_binding.dart';
import 'package:reading_app/features/main/presentation/page/main_page.dart';
import 'package:reading_app/features/splash/di/splash_binding.dart';
import 'package:reading_app/features/splash/presentation/pages/splash_page.dart';

class Pages {
  static const initial = Routes.splash;
  static const main = Routes.main;
  static final routes = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainBindding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    ...AuthRoutes.routes,
    ...ComicRoutes.routes,
    ...CommentRoutes.routes,
    ...ExploreRoutes.routes,
    ...NovelRoutes.routes,
    ...ProfileRoutes.routes,
  ];
}
