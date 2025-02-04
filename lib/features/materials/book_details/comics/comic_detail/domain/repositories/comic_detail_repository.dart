import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';

abstract class ComicDetailRepository {
  Future<ComicModel?> fetchComicBySlug(String slug);
  Future<List<CommentResponse>> fetchCommentsComic(String comicId);
}
