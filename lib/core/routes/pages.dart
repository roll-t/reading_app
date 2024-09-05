import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/auth/forgot_password/di/forgot_password_binding.dart';
import 'package:reading_app/features/auth/forgot_password/presentation/page/forgot_password_page.dart';
import 'package:reading_app/features/auth/login/di/login_binding.dart';
import 'package:reading_app/features/auth/login/presentation/page/login_page.dart';
import 'package:reading_app/features/auth/register/di/register_binding.dart';
import 'package:reading_app/features/auth/register/presentation/page/register_page.dart';
import 'package:reading_app/features/expanded/book/di/book_detail_binding.dart';
import 'package:reading_app/features/expanded/book/di/book_read_binding.dart';
import 'package:reading_app/features/expanded/book/presentation/pages/book_detail_page.dart';
import 'package:reading_app/features/expanded/book/presentation/pages/book_read_page.dart';
import 'package:reading_app/features/expanded/category/di/category_binding.dart';
import 'package:reading_app/features/expanded/category/presentation/page/category_page.dart';
import 'package:reading_app/features/expanded/comment/di/comment_binding.dart';
import 'package:reading_app/features/expanded/comment/presentation/page/comment_page.dart';
import 'package:reading_app/features/expanded/explores/find/di/find_binding.dart';
import 'package:reading_app/features/expanded/explores/find/presentation/page/find_page.dart';
import 'package:reading_app/features/expanded/explores/search_book/di/search_book_binding.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/search_book_page.dart';
import 'package:reading_app/features/expanded/notification/di/notification_binding.dart';
import 'package:reading_app/features/expanded/notification/presentation/page/notification_page.dart';
import 'package:reading_app/features/main/di/main_binding.dart';
import 'package:reading_app/features/main/presentation/page/main_page.dart';
import 'package:reading_app/features/nav/profile/di/my_info_binding.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/page/my_info_page.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';
import 'package:reading_app/features/splash/di/splash_binding.dart';
import 'package:reading_app/features/splash/presentation/pages/login_request_splash_page.dart';
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
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
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
      name: Routes.bookDetail,
      page: () => const BookDetailPage(),
      binding: BookDetailBinding(),
    ),
    GetPage(
      name: Routes.comment,
      page: () => const CommentPage(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: Routes.readBook,
      page: () => const BookReadPage(),
      binding: BookReadBinding(),
    ),
    GetPage(
      name: Routes.loginRequestSplash,
      page: () => const LoginRequestSplashPage(),
      binding: SplashBinding()
    ),
  ];
}
