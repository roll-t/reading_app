import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/api/locals/comment_service.dart';
import 'package:reading_app/core/service/api/remotes/comic_service.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';
import 'package:reading_app/features/materials/book/comic/comic_detail/domain/repositories/comic_detail_repository.dart';

class ComicDetailRepositoryImpl implements ComicDetailRepository {
  final ComicApi _comicService;
  final CommentService _commentService;

  ComicDetailRepositoryImpl(this._comicService, this._commentService);

  @override
  Future<ComicModel?> fetchComicBySlug(String slug) async {
    try {
      Result<ComicModel> result =
          await _comicService.fetchBookBySlug(slug: slug);
      if (result.status == Status.success) {
        return result.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<List<CommentResponse>> fetchCommentsComic(String comicId) async {
    try {
      var result = await _commentService.fetchAllComment(bookId: comicId);
      if (result.status == Status.success) {
        return result.data ?? [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
