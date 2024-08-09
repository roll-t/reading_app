

import 'package:get/get.dart';
import 'package:reading_app/features/expanded/comment/presentation/controller/comment_controller.dart';

class CommentBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CommentController());
  }

}