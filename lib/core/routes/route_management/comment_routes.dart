import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/content/comment/di/comment_binding.dart';
import 'package:reading_app/features/content/comment/presentation/page/comment_page.dart';

class CommentRoutes {
  static final routes = [
    // Comment Routes
    GetPage(
      name: Routes.comment,
      page: () => const CommentPage(),
      binding: CommentBinding(),
    ),
  ];
}
