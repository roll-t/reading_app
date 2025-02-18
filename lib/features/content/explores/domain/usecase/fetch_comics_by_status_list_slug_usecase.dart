import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/content/explores/domain/repositories/explore_repository.dart';

class FetchComicsByStatusListSlugUsecase {
  final ExploreRepository _repository;
  FetchComicsByStatusListSlugUsecase(this._repository);
  Future<ListComicModel?> call({
    required String statusSlug,
    int page = 1,
  }) async {
    return await _repository.fetchComicsByStatusList(statusSlug: statusSlug);
  }
}
