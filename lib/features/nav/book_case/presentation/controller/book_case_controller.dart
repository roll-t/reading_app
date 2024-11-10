import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/book_case_data.dart';
import 'package:reading_app/core/data/database/model/reading_book_case_model.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';
import 'package:reading_app/core/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/data/sql/data_helper.dart';
import 'package:reading_app/features/nav/book_case/model/book_case_model.dart';

class BookCaseController extends GetxController {
  RxString typeSelect = "Tiểu thuyết".obs;
  RxString filterType = "Mới nhất".obs;
  var isLoading = false.obs;
  BookCaseData bookCaseData = BookCaseData();
  List<ReadingBookCaseResponse> listReadingBookCase = [];
  List<BookCaseModel> listBookData = [];
  List<ReadingComicBookCaseModel> listBookComic = [];
  final dbHelper = DatabaseHelper();

  List<PopupMenuItem<String>> selectedValue = [
    const PopupMenuItem<String>(
      value: 'Tiểu thuyết',
      child: Text('Tiểu thuyết'),
    ),
    const PopupMenuItem<String>(
      value: 'Truyện tranh',
      child: Text('Truyện tranh'),
    ),
  ];

  @override
  onInit() async {
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
    listBookComic = await dbHelper.getReadingComicBookCasesByUid(authID);

    if (listReadingBookCase.isEmpty) {
      handleChangeTypeRead("Truyện tranh");
    }

    isLoading.value = false;
    update(["LoadReadingBookCase"]);
  }

  void sortBooksByType(String type) {
    listReadingBookCase.sort((a, b) {
      DateTime dateA;
      DateTime dateB;
      if (type == "updatedAt") {
        dateA = a.bookData.updatedAt;
        dateB = b.bookData.updatedAt;
      } else {
        dateA = a.readingDate;
        dateB = b.readingDate;
      }
      return dateB.compareTo(dateA); // Sắp xếp giảm dần
    });
    update(["reloadReadingBookCase"]);
  }

  // Reload reading book cases data (from API)
  Future<void> reloadListReadingBookCase() async {
    isLoading.value = true;
    final auth = await AuthUseCase.getAuthToken();
    // ignore: unnecessary_null_comparison
    final authID = auth != null ? JwtDecoder.decode(auth)["uid"] : "";

    // Fetch reading book cases from the API again
    final result = await bookCaseData.fetchAllReadingBookCase(uid: authID);
    if (result.status == Status.success) {
      listReadingBookCase = result.data ?? [];
    }

    isLoading.value = false;
    update(["LoadReadingBookCase"]);
  }

  handleChangeTypeRead(String value) {
    typeSelect.value = value;
    update(["LoadReadingBookCase"]);
  }

  Future<void> reloadListBookComic() async {
    isLoading.value = true;
    final auth = await AuthUseCase.getAuthToken();
    // ignore: unnecessary_null_comparison
    final authID = auth != null ? JwtDecoder.decode(auth)["uid"] : "";
    listBookComic = await dbHelper.getReadingComicBookCasesByUid(authID);
    isLoading.value = false;
    update(["reloadReadingBookCase"]);
  }

  Future<void> handleDelete({required String readingBookCaseID}) async {
    try {
      await BookCaseData.handleDeleReadingBookCase(bcId: readingBookCaseID);
      await initial();
      update(["reloadReadingBookCase"]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleDeleteComic(
      {required ReadingComicBookCaseModel bookModel}) async {
    try {
      dbHelper.deleteReadingComicBookCase(bookModel);
      await initial();
      update(["reloadComicBookCase"]);
    } catch (e) {
      print(e);
    }
  }
}
