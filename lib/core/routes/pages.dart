import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/auth/login/di/login_binding.dart';
import 'package:reading_app/features/auth/login/presentation/page/login_page.dart';
import 'package:reading_app/features/auth/register/di/register_binding.dart';
import 'package:reading_app/features/auth/register/presentation/page/register_page.dart';
import 'package:reading_app/features/main/di/main_binding.dart';
import 'package:reading_app/features/main/presentation/page/main_page.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/di/comic_detail_binding.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/presentation/pages/comic_detail_page.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_read/di/read_comic_binding.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_read/presentation/pages/read_comic_page.dart';
import 'package:reading_app/features/materials/book_details/novels/di/novel_binding.dart';
import 'package:reading_app/features/materials/book_details/novels/di/read_novel_binding.dart';
import 'package:reading_app/features/materials/book_details/novels/presentation/page/novel_detail_page.dart';
import 'package:reading_app/features/materials/book_details/novels/presentation/page/read_novel_page.dart';
import 'package:reading_app/features/materials/categories/comics/di/category_binding.dart';
import 'package:reading_app/features/materials/categories/comics/presentation/pages/category_comic_page.dart';
import 'package:reading_app/features/materials/categories/novels/presentation/page/category_novel_page.dart';
import 'package:reading_app/features/materials/comment/di/comment_binding.dart';
import 'package:reading_app/features/materials/comment/presentation/page/comment_page.dart';
import 'package:reading_app/features/materials/explores/find/di/find_binding.dart';
import 'package:reading_app/features/materials/explores/find/presentation/page/find_novel_page.dart';
import 'package:reading_app/features/materials/explores/find/presentation/page/find_page.dart';
import 'package:reading_app/features/materials/explores/search_book/di/search_book_binding.dart';
import 'package:reading_app/features/materials/explores/search_book/presentation/page/search_book_page.dart';
import 'package:reading_app/features/materials/notification/di/notification_binding.dart';
import 'package:reading_app/features/materials/notification/presentation/page/notification_page.dart';
import 'package:reading_app/features/nav/profile/di/my_info_binding.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/page/my_info_page.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';
import 'package:reading_app/features/splash/di/splash_binding.dart';
import 'package:reading_app/features/splash/presentation/pages/splash_page.dart';

class Pages {
  static const initial = Routes.splash;
  static const main = Routes.main;
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBindding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: Routes.profile,
        page: () => const ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBindding(),
    ),
    GetPage(
      name: Routes.findNovel,
      page: () => const FindNovelPage(),
      binding: FindBinding(),
    ),
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
    GetPage(
      name: Routes.category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.categoryNovel,
      page: () => const CategoryNovelPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchBookPage(),
      binding: SearchBookBinding(),
    ),
    GetPage(
      name: Routes.myInfo,
      page: () => const MyInfoPage(),
      binding: MyInfoBinding(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.find,
      page: () => const FindPage(),
      binding: FindBinding(),
    ),
    GetPage(
      name: Routes.comment,
      page: () => const CommentPage(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: Routes.readBook,
      page: () => const ReadComicPage(),
      binding: ReadComicBinding(),
    ),
    GetPage(
      name: Routes.novelDetail,
      page: () => const NovelDetailPage(),
      binding: NovelBinding(),
    ),
    GetPage(
        name: Routes.readNovel,
        page: () => const ReadNovelPage(),
        binding: ReadNovelBinding()),
    GetPage(
        name: Routes.comicDetail,
        page: () => const ComicDetailPage(),
        binding: ComicDetailBinding()),
  ];
}
