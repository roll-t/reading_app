import 'package:reading_app/core/services/entities/dto/response/novel_response.dart';
import 'package:reading_app/features/comic/domain/repositories/search_repository.dart';

class FetchNovelSearchUsecase {
  final SearchRepository _repository;

  FetchNovelSearchUsecase(this._repository);

  Future<List<NovelResponse>?> call({
    required contentSearch,
  }) async {
    return _repository.fetchNovelsSearch(
      contentSearch: contentSearch,
    );
  }
}
