import 'package:get/get.dart';

class WidgetController extends GetxController {
  var readMore = false.obs;

  void toggleReadMore() {
    readMore.value = !readMore.value;
  }

  var currentRating = 0.0.obs;

  void updateRating(double rating) {
    currentRating.value = rating;
  }
}
