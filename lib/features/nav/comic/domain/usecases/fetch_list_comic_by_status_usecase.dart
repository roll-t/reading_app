import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/features/nav/comic/domain/repositories/comic_repository.dart';

class FetchListComicByStatusUsecase {
  final ComicRepository _repository;

  FetchListComicByStatusUsecase(this._repository);

  Future<ListComicModel?> call(String status) async {
    return _repository.fetchListByStatus(status);
  }
}
