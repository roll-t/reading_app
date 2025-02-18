import 'package:reading_app/features/dashboard/book_case/domain/repositories/book_case_repository.dart';

class RemoveNovelFavoriteUsecase {
  final BookCaseRepository _repository;

  RemoveNovelFavoriteUsecase(this._repository);

  Future<void> call({
    required String bookId,
    required String uid,
  }) async {
    await _repository.removeFavoriteNovel(
      bookId: bookId,
      uid: uid,
    );
  }
}
