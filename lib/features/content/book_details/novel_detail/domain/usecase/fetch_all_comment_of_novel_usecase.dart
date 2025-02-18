import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/repositories/novel_detail_repository.dart';

class FetchAllCommentOfNovelUsecase {
  final NovelDetailRepository _repository;
  FetchAllCommentOfNovelUsecase(this._repository);

  Future<List<CommentResponse>?> call({required String novelId}) async {
    return await _repository.fetchAlComment(novelId: novelId);
  }
}
