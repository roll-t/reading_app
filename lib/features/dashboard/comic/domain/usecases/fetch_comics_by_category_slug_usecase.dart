import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/dashboard/comic/domain/repositories/comic_repository.dart';

class FetchComicsByCategorySlugUsecase {
  final ComicRepository _repository;

  FetchComicsByCategorySlugUsecase(this._repository);

  Future<ListComicModel?> call(String slug) async {
    return await _repository.fetchComicsByCategorySlug(slug);
  }
}
