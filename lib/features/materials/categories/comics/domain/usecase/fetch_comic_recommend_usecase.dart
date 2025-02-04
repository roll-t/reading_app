import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/materials/categories/comics/domain/repositories/comic_category_repository.dart';

class FetchComicRecommendUsecase {
  final ComicCategoryRepository _repository;
  FetchComicRecommendUsecase(this._repository);

  Future<ListComicModel?> call() async {
    return _repository.fetchComicRecommend();
  }
}
