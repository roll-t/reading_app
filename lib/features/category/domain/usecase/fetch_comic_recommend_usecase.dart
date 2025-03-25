import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/features/category/domain/repositories/comic_category_repository.dart';

class FetchComicRecommendUsecase {
  final ComicCategoryRepository _repository;
  FetchComicRecommendUsecase(this._repository);

  Future<ListComicModel?> call() async {
    return _repository.fetchComicRecommend();
  }
}
