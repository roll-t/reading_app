import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_repository.dart';

class FetchListComicByStatusUsecase {
  final ComicRepository _repository;

  FetchListComicByStatusUsecase(this._repository);

  Future<ListComicModel?> call({required String status, int page = 1}) async {
    print("page = $page");
    return _repository.fetchListByStatus(status: status, page: page);
  }
}
