import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/content/searches/domain/repositories/search_repository.dart';

class FetchComicsSearchUsecase {
  final SearchRepository _repository;

  FetchComicsSearchUsecase(this._repository);

  Future<ListComicModel?> call({
    required contentSearch,
    int page = 1,
  }) async {
    return _repository.fetchComicsSearch(
      contentSearch: contentSearch,
      page: page,
    );
  }
}
