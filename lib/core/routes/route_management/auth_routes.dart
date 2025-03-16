import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/auth/di/auth_binding.dart';
import 'package:reading_app/features/auth/presentation/login/page/login_page.dart';
import 'package:reading_app/features/auth/presentation/register/page/register_page.dart';

class AuthRoutes {
  static final routes = [
    // Auth Routes
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
  ];
}
