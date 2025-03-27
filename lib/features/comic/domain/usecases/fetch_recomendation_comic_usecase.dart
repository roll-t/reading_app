import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_repository.dart';

class FetchRecommendationComicUsecase {
  final ComicRepository _repository;
  FetchRecommendationComicUsecase(this._repository);

  Future<ListComicModel?> call() async {
    return _repository.fetchHomeData();
  }
}
