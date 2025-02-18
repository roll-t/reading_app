

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/dashboard/profile/di/my_info_binding.dart';
import 'package:reading_app/features/dashboard/profile/di/profile_binding.dart';
import 'package:reading_app/features/dashboard/profile/presentation/page/my_info_page.dart';
import 'package:reading_app/features/dashboard/profile/presentation/page/profile_page.dart';

class ProfileRoutes {
  static final routes =[
    // Profile Routes
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.myInfo,
      page: () => const MyInfoPage(),
      binding: MyInfoBinding(),
    ),
  ];
}