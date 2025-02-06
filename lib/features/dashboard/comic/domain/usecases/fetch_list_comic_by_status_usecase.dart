import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/dashboard/comic/domain/repositories/comic_repository.dart';

class FetchListComicByStatusUsecase {
  final ComicRepository _repository;

  FetchListComicByStatusUsecase(this._repository);

  Future<ListComicModel?> call(String status) async {
    return _repository.fetchListByStatus(status);
  }
}
