import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';

abstract class SearchRepository {
  Future<ListComicModel?> fetchComicsSearch({
    required String contentSearch,
    int page = 1,
  });
  Future<List<NovelResponse>?> fetchNovelsSearch({
    required String contentSearch,
    int page = 1,
  });
  Future<ListComicModel?> fetchComicsDefaultSearch();
}
