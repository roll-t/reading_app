import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/comic_model.dart';

abstract class ComicDetailRepository {
  Future<ComicModel?> fetchComicBySlug(String slug);
  Future<List<CommentResponse>> fetchCommentsComic(String comicId);
}
