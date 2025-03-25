import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/auth/di/user_binding.dart';
import 'package:reading_app/features/auth/presentation/user/pages/profile_detail_page.dart';
import 'package:reading_app/features/auth/presentation/user/pages/profile_page.dart';

class ProfileRoutes {
  static final routes = [
    // Profile Routes
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.myInfo,
      page: () => const ProfileDetailPage(),
      binding: UserBinding(),
    ),
  ];
}
