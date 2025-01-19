import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/features/nav/comic/domain/repositories/comic_repository.dart';

class FetchHomeDataUsecase {
  final ComicRepository _repository;
  FetchHomeDataUsecase(this._repository);

  Future<ListComicModel?> call() async {
    return _repository.fetchHomeData();
  }
}
