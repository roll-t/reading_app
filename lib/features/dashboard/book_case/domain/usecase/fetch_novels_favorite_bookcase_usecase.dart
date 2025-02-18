import 'package:reading_app/core/services/api/data/entities/dto/response/favorite_response.dart';
import 'package:reading_app/features/dashboard/book_case/domain/repositories/book_case_repository.dart';

class FetchNovelsFavoriteBookcaseUsecase {
  final BookCaseRepository _repository;

  FetchNovelsFavoriteBookcaseUsecase(this._repository);

  Future<List<FavoriteResponse>?> call({required String uid}) async {
    return await _repository.fetchNovelsFavorite(uid: uid);
  }
}
