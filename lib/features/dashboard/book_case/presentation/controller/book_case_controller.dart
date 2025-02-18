import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/favorite_response.dart'; // Import FavoriteResponse
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/reading_book_case_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/auth_use_case.dart';
import 'package:reading_app/core/storage/sql/data_helper.dart';
import 'package:reading_app/features/dashboard/book_case/data/entities/book_case_model.dart';
import 'package:reading_app/features/dashboard/book_case/domain/usecase/fetch_novels_bookcase_usecase.dart';
import 'package:reading_app/features/dashboard/book_case/domain/usecase/fetch_novels_favorite_bookcase_usecase.dart';
import 'package:reading_app/features/dashboard/book_case/domain/usecase/remove_novel_favorite_usecase.dart';

class BookCaseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FetchNovelsBookcaseUsecase _fetchNovelsBookcaseUsecase;
  final FetchNovelsFavoriteBookcaseUsecase _fetchNovelsFavoriteBookcaseUsecase;
  final RemoveNovelFavoriteUsecase _removeNovelFavoriteUsecase;

  BookCaseController(
    this._fetchNovelsBookcaseUsecase,
    this._fetchNovelsFavoriteBookcaseUsecase,
    this._removeNovelFavoriteUsecase,
  );

  late TabController tabController;

  RxString typeSelect = "Tiểu thuyết".obs;
  RxString filterType = "Mới nhất".obs;

  var isLoading = false.obs;

  RxList<ReadingBookCaseResponse> novelsReadingBookcase =
      <ReadingBookCaseResponse>[].obs;

  List<BookCaseModel> listBookData = [];

  RxList<ReadingComicBookCaseModel> comicsReadingBookcase =
      <ReadingComicBookCaseModel>[].obs;

  RxList<FavoriteResponse> novelsFavoriteBookcase = <FavoriteResponse>[].obs;

  final dbHelper = DatabaseHelper();

  dynamic userId;

  @override
  onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleChangeTab);
    await initial();
  }

  Future<void> initial() async {
    isLoading.value = true;
    final auth = await AuthUseCase.getAuthToken();
    // ignore: unnecessary_null_comparison
    userId = auth != null ? JwtDecoder.decode(auth)["uid"] : "";

    if (userId != null) {
      await fetchReadingBookCases(userId);
    }

    if (novelsReadingBookcase.isEmpty) {
      handleChangeTypeRead("Truyện tranh");
    }

    isLoading.value = false;
    update(["LoadReadingBookCase"]);
  }

  Future<void> _handleChangeTab() async {
    fetchFavoriteBooks(userId);
  }

  Future<void> fetchFavoriteBooks(String authID) async {
    novelsFavoriteBookcase.value =
        await _fetchNovelsFavoriteBookcaseUsecase(uid: authID) ?? [];
  }

  Future<void> fetchReadingBookCases(String authID) async {
    novelsReadingBookcase.value =
        await _fetchNovelsBookcaseUsecase(uid: authID) ?? [];
  }

  Future<void> fetchComicBookCases(String authID) async {
    comicsReadingBookcase.value =
        await dbHelper.getReadingComicBookCasesByUid(authID);
  }

  void sortBooksByType(String type) {
    novelsReadingBookcase.sort(
      (a, b) {
        DateTime dateA =
            type == "updatedAt" ? a.bookData.updatedAt : a.readingDate;
        DateTime dateB =
            type == "updatedAt" ? b.bookData.updatedAt : b.readingDate;
        return dateB.compareTo(dateA);
      },
    );
  }

  Future<void> reloadListBookComic() async {
    isLoading.value = true;
    comicsReadingBookcase.value =
        await dbHelper.getReadingComicBookCasesByUid(userId);
    isLoading.value = false;
    update(["reloadReadingBookCase"]);
  }

  void handleChangeTypeRead(String value) {
    typeSelect.value = value;
    fetchComicBookCases(userId);
  }

  Future<void> handleDelete({required String readingBookCaseID}) async {
    try {
      // await BookCaseData.handleDeleReadingBookCase(bcId: readingBookCaseID);
      novelsReadingBookcase.removeWhere(
          (item) => item.id == readingBookCaseID); // Remove item from list
      update(["reloadReadingBookCase"]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleDeleteFavorite({required String bookId}) async {
    try {
      await _removeNovelFavoriteUsecase(bookId: bookId, uid: userId);
      novelsFavoriteBookcase
          .removeWhere((item) => item.bookData.bookDataId == bookId);
      update(["reloadFavoriteBookCase"]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleDeleteComic(
      {required ReadingComicBookCaseModel bookModel}) async {
    try {
      await dbHelper.deleteReadingComicBookCase(bookModel);
      comicsReadingBookcase.remove(bookModel);
      update(["reloadComicBookCase"]);
    } catch (e) {
      print(e);
    }
  }
}
