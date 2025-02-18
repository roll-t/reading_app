import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/favorite_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/reading_book_case_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/book_case_service.dart';
import 'package:reading_app/features/dashboard/book_case/domain/repositories/book_case_repository.dart';

class BookCaseRepositoryImpl implements BookCaseRepository {
  final BookCaseService _bookCaseService;
  BookCaseRepositoryImpl(this._bookCaseService);

  @override
  Future<ReadingComicBookCaseModel?> fetchComicsBookcase() {
    throw UnimplementedError();
  }

  @override
  Future<List<ReadingBookCaseResponse>?> fetchNovelsBookcase({
    required String uid,
  }) async {
    try {
      var result = await _bookCaseService.fetchAllReadingBookCase(uid: uid);
      return result.status == Status.success ? result.data : [];
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<FavoriteResponse>?> fetchNovelsFavorite({
    required String uid,
  }) async {
    try {
      var result = await _bookCaseService.fetchAllFavoriteBooks(userId: uid);
      return result.status == Status.success ? result.data : [];
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> removeFavoriteNovel({
    required String bookId,
    required String uid,
  }) async {
    try {
      await _bookCaseService.unlikeBook(bookDataId: bookId, userId: uid);
    } catch (e) {
      print(e);
    }
  }
}
