import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';

abstract class ComicCategoryRepository {
  Future<ListComicModel?> fetchComicRecommend();
  Future<ListComicModel?> fetchComicsBySlug(
      {required String slug, int page = 1});
  Future<ListComicModel?> fetchComicsByCategorySlug(
      {required String slug, int page = 1});
}
