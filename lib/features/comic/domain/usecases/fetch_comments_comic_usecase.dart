import 'package:reading_app/core/services/entities/dto/response/commentReponse.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_detail_repository.dart';

class FetchCommentsComicUsecase {
  final ComicDetailRepository _repository;

  FetchCommentsComicUsecase(this._repository);

  Future<List<CommentResponse>> call(String comicId) async {
    return await _repository.fetchCommentsComic(comicId);
  }
}
