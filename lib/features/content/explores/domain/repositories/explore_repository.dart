import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';

abstract class ExploreRepository {
  Future<ListComicModel?> fetchComicsByCategorySlug({
    required String slug,
    int page = 1,
  });

  Future<List<NovelResponse>?> fetchNovelsByCategorySlug({
    required String slug,
    int page = 1,
  });

  Future<ListComicModel?> fetchComicsByStatusAndCategorySlug({
    required String categorySlug,
    required String status,
    int page = 1,
  });

  Future<ListComicModel?> fetchComicsByStatusList({
    required String statusSlug,
    int page = 1,
  });

  Future<List<NovelResponse>?> fetchNovelByCategorySlugAndStatus({
    required String statusSlug,
    required String categorySlug,
    int page = 1,
  });
}
