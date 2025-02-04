import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/domain/repositories/comic_detail_repository.dart';

class FetchComicBySlugUsecase {
  final ComicDetailRepository _repository;

  FetchComicBySlugUsecase(this._repository);

  Future<ComicModel?> call(String slug) async {
    return await _repository.fetchComicBySlug(slug);
  }
}
