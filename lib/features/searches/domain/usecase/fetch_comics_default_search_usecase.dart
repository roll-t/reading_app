import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/features/searches/domain/repositories/search_repository.dart';

class FetchComicsDefaultSearchUsecase {
  final SearchRepository _repository;

  FetchComicsDefaultSearchUsecase(this._repository);

  Future<ListComicModel?> call() async {
    return _repository.fetchComicsDefaultSearch();
  }
}
