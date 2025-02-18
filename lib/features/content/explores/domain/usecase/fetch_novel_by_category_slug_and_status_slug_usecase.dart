import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/features/content/explores/domain/repositories/explore_repository.dart';

class FetchNovelByCategorySlugAndStatusSlugUsecase {
  final ExploreRepository _repository;

  FetchNovelByCategorySlugAndStatusSlugUsecase(this._repository);

  Future<List<NovelResponse>?> call({
    required String statusSlug,
    required String categorySlug,
    int page = 1,
  }) async {
    return await _repository.fetchNovelByCategorySlugAndStatus(
      statusSlug: statusSlug,
      categorySlug: categorySlug,
      page: page,
    );
  }
}
