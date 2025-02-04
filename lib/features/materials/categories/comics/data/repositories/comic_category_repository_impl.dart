import 'dart:developer';

import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/features/materials/categories/comics/domain/repositories/comic_category_repository.dart';

class ComicCategoryRepositoryImpl implements ComicCategoryRepository {
  final ComicApi _comicApi;
  ComicCategoryRepositoryImpl(this._comicApi);

  @override
  Future<ListComicModel?> fetchComicRecommend() async {
    try {
      var result = await _comicApi.fetchHomeData();
      if (result.status == Status.success) {
        return result.data;
      }
    } catch (e, stacktrace) {
      log("Error in fetchComicRecommend: $e", stackTrace: stacktrace);
    }
    return null;
  }

  @override
  Future<ListComicModel?> fetchComicsByCategorySlug(
      {required String slug, int page = 1}) async {
    try {
      var result = await _comicApi.fetchComicCategoryBySlug(slug: slug, page: page);
      if (result.status == Status.success) {
        return result.data;
      }
    } catch (e, stacktrace) {
      log("Error in fetchComicsByCategorySlug: $e", stackTrace: stacktrace);
    }
    return null;
  }

  @override
  Future<ListComicModel?> fetchComicsBySlug(
      {required String slug, int page = 1}) async {
    try {
      var result = await _comicApi.fetchListBySlug(slug: slug, page: page);
      if (result.status == Status.success) {
        return result.data;
      }
    } catch (e, stacktrace) {
      log("Error in fetchComicsBySlug: $e", stackTrace: stacktrace);
    }
    return null;
  }
}
