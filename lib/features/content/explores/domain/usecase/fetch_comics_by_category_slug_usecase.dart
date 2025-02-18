import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/content/explores/domain/repositories/explore_repository.dart';

class FetchComicsByCategorySlugUsecase {
  final ExploreRepository _repository;
  FetchComicsByCategorySlugUsecase(this._repository);

  Future<ListComicModel?> call({required String slug, int page = 1}) async {
    return await _repository.fetchComicsByCategorySlug(slug: slug, page: page);
  }
}
