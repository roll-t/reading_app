import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/domain/repositories/comic_detail_repository.dart';

class FetchCommentsComicUsecase {
  final ComicDetailRepository _repository;

  FetchCommentsComicUsecase(this._repository);

  Future<List<CommentResponse>> call(String comicId) async {
    return await _repository.fetchCommentsComic(comicId);
  }
}
