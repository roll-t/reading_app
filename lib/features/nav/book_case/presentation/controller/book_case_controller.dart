import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/data/api/database/book_case_service.dart';
import 'package:reading_app/core/service/data/dto/response/favorite_response.dart'; // Import FavoriteResponse
import 'package:reading_app/core/service/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/service/data/model/reading_book_case_model.dart';
import 'package:reading_app/core/storage/sql/data_helper.dart';
import 'package:reading_app/core/storage/use_case/auth_use_case.dart';
import 'package:reading_app/features/nav/book_case/model/book_case_model.dart';

class BookCaseController extends GetxController {
  RxString typeSelect = "Tiểu thuyết".obs;
  RxString filterType = "Mới nhất".obs;
  var isLoading = false.obs;
  BookCaseData bookCaseData = BookCaseData();
  List<ReadingBookCaseResponse> listReadingBookCase = [];
  List<BookCaseModel> listBookData = [];
  List<ReadingComicBookCaseModel> listBookComic = [];
  List<FavoriteResponse> listFavoriteBooks = [];
  final dbHelper = DatabaseHelper();

  dynamic userId;

  List<PopupMenuItem<String>> selectedValue = [
    const PopupMenuItem<String>(
        value: 'Tiểu thuyết', child: Text('Tiểu thuyết')),
    const PopupMenuItem<String>(
        value: 'Truyện tranh', child: Text('Truyện tranh')),
  ];

  @override
  onInit() async {
    super.onInit();
    await initial();
  }

  Future<void> initial() async {
    isLoading.value = true;
    final auth = await AuthUseCase.getAuthToken();
    // ignore: unnecessary_null_comparison
    userId = auth != null ? JwtDecoder.decode(auth)["uid"] : "";

    if (userId != null) {
      // Fetch the favorite books and reading book cases
      await Future.wait([
        fetchFavoriteBooks(userId),
        fetchReadingBookCases(userId),
        fetchComicBookCases(userId)
      ]);
    }

    if (listReadingBookCase.isEmpty) {
      handleChangeTypeRead("Truyện tranh");
    }

    isLoading.value = false;
    update(["LoadReadingBookCase"]);
  }

  Future<void> fetchFavoriteBooks(String authID) async {
    final result = await bookCaseData.fetchAllFavoriteBooks(userId: authID);
    if (result.status == Status.success) {
      listFavoriteBooks = result.data ?? [];
    }
    update(["LoadFavoriteBookCase"]);
  }

  Future<void> fetchReadingBookCases(String authID) async {
    final result = await bookCaseData.fetchAllReadingBookCase(uid: authID);
    if (result.status == Status.success) {
      listReadingBookCase = result.data ?? [];
    }
  }

  Future<void> fetchComicBookCases(String authID) async {
    listBookComic = await dbHelper.getReadingComicBookCasesByUid(authID);
  }

  void sortBooksByType(String type) {
    listReadingBookCase.sort((a, b) {
      DateTime dateA =
          type == "updatedAt" ? a.bookData.updatedAt : a.readingDate;
      DateTime dateB =
          type == "updatedAt" ? b.bookData.updatedAt : b.readingDate;
      return dateB.compareTo(dateA);
    });
    update(["reloadReadingBookCase"]);
  }

  Future<void> reloadListReadingBookCase() async {
    isLoading.value = true;
    await fetchReadingBookCases(userId);
    isLoading.value = false;
    update(["LoadReadingBookCase"]);
  }

  Future<void> reloadListBookComic() async {
    isLoading.value = true;
    listBookComic = await dbHelper.getReadingComicBookCasesByUid(userId);
    isLoading.value = false;
    update(["reloadReadingBookCase"]);
  }

  void handleChangeTypeRead(String value) {
    typeSelect.value = value;
    update(["LoadReadingBookCase"]);
  }

  Future<void> handleDelete({required String readingBookCaseID}) async {
    try {
      await BookCaseData.handleDeleReadingBookCase(bcId: readingBookCaseID);
      listReadingBookCase.removeWhere(
          (item) => item.id == readingBookCaseID); // Remove item from list
      update(["reloadReadingBookCase"]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleDeleteFavorite({required String bookId}) async {
    try {
      await bookCaseData.unlikeBook(bookDataId: bookId, userId: userId);
      listFavoriteBooks.removeWhere((item) =>
          item.bookData.bookDataId == bookId); // Remove item from list
      update(["reloadFavoriteBookCase"]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleDeleteComic(
      {required ReadingComicBookCaseModel bookModel}) async {
    try {
      await dbHelper.deleteReadingComicBookCase(bookModel);
      listBookComic.remove(bookModel); // Remove item from list
      update(["reloadComicBookCase"]);
    } catch (e) {
      print(e);
    }
  }
}
