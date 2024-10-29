import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/book_case_data.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';
import 'package:reading_app/core/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/features/nav/book_case/model/book_case_model.dart';

class BookCaseController extends GetxController {
  RxString typeSelect = "Tất cả".obs;
  RxString filterType = "Mới nhất".obs;
  var isLoading = false.obs;
  BookCaseData bookCaseData =BookCaseData();

  List<ReadingBookCaseResponse> listReadingBookCase = [];
  List<BookCaseModel> listBookData = [];

  @override
  onInit() {
    super.onInit();
    initial();
  }

  Future<void> initial() async {
    isLoading.value = true;
    final auth = await AuthUseCase.getAuthToken();
    // ignore: unnecessary_null_comparison
    final authID = auth != null ? JwtDecoder.decode(auth)["uid"] : "";
    final result = await bookCaseData.fetchAllReadingBookCase(uid: authID);
    if (result.status == Status.success) {
      listReadingBookCase = result.data ?? [];
    }

    isLoading.value = false;
    update(["LoadReadingBookCase"]);
  }

  Future<void> handleDelete({required String readingBookCaseID}) async {
    try {
      await BookCaseData.handleDeleReadingBookCase(bcId: readingBookCaseID);
      await initial();
      update(["LoadReadingBookCase"]);
    } catch (e) {
      print(e);
    }
  }
}
