import 'package:get/get.dart';
import 'package:reading_app/core/service/api/database/book_case_service.dart';

class LikeController extends GetxController {
  var isFavorite = false.obs; // This will track whether the book is liked or not

  final BookCaseData bookCaseData;

  LikeController({required this.bookCaseData});

}
