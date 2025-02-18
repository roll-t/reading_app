import 'package:reading_app/core/services/api/data/entities/dto/response/favorite_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/reading_book_case_model.dart';

abstract class BookCaseRepository {
  Future<List<FavoriteResponse>?> fetchNovelsFavorite({required String uid});
  Future<ReadingComicBookCaseModel?> fetchComicsBookcase();
  Future<List<ReadingBookCaseResponse>?> fetchNovelsBookcase({required String uid});
  Future<void> removeFavoriteNovel({required String bookId, required String uid});
}
