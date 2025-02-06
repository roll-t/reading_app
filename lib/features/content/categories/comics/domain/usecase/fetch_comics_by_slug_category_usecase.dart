import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/content/categories/comics/domain/repositories/comic_category_repository.dart';

class FetchComicsBySlugCategoryUsecase {
  final ComicCategoryRepository _repository;
  FetchComicsBySlugCategoryUsecase(this._repository);
  Future<ListComicModel?> call({required String slug, int page = 1}) async {
    return _repository.fetchComicsByCategorySlug(slug: slug, page: page);
  }
}
