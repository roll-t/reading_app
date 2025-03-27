import 'package:reading_app/core/services/entities/dto/response/novel_response.dart';
import 'package:reading_app/features/comic/domain/repositories/explore_repository.dart';

class FetchNovelsByCategorySlugUsecase {
  final ExploreRepository _repository;

  FetchNovelsByCategorySlugUsecase(this._repository);

  Future<List<NovelResponse>?> call(
      {required String slug, int page = 1}) async {
    return await _repository.fetchNovelsByCategorySlug(slug: slug, page: page);
  }
}
