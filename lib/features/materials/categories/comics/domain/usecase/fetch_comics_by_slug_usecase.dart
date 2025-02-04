import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/materials/categories/comics/domain/repositories/comic_category_repository.dart';

class FetchComicsBySlugUsecase {
  final ComicCategoryRepository _repository;
  FetchComicsBySlugUsecase(this._repository);
  
  Future<ListComicModel?> call({required String slug, int page = 1}) async {
    return _repository.fetchComicsBySlug(slug: slug, page: page);
  }
}
