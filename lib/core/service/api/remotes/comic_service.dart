import 'dart:async';

import 'package:dio/dio.dart';
import 'package:reading_app/core/configs/end_point_config.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/data/dto/response/response_comic_api.dart';
import 'package:reading_app/core/service/data/model/chapter_model.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class ComicApi extends ApiService {
  ComicApi(super.dioConfig, super.cacheService);

  Future<Result<ComicModel>> fetchBookBySlug({required String slug}) async {
    return await fetchData(
      endpoint: EndPointSetting.comicDetailEndpoint(slug: slug),
      parse: (data) => ComicModel.fromJson(data),
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy dữ liệu trang chủ
  Future<Result<ListComicModel>> fetchHomeData() async {
    return await fetchData(
      endpoint: EndPointSetting.comicHomeEndpoint(),
      parse: (data) =>
          ResponseComicApi.handleResponseData(200, data: data).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy danh sách theo slug và trang
  Future<Result<ListComicModel>> fetchListBySlug(
      {required String slug, required int page}) async {
    return await fetchData(
      endpoint: EndPointSetting.listByTypeEndpoint(slug: slug, page: page),
      parse: (data) =>
          ResponseComicApi.handleResponseData(200, data: data).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy danh sách tìm kiếm theo slug và trang
  Future<Result<ListComicModel>> fetchListSearchBySlug(
      {required String slug, required int page}) async {
    return await fetchData(
      endpoint: EndPointSetting.searchBySlugEndpoint(slug: slug, page: page),
      parse: (data) =>
          ResponseComicApi.handleResponseData(200, data: data).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy danh sách comic theo slug và trang
  Future<Result<ListComicModel>> fetchComicCategoryBySlug(
      {required String slug, required int page}) async {
    return await fetchData(
      endpoint:
          EndPointSetting.categoriesBySlugEndpoint(slug: slug, page: page),
      parse: (data) =>
          ResponseComicApi.handleResponseData(200, data: data).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy thông tin chapter của comic
  Future<Result<ChapterModel>> fetchChapterAPI(
      {required Map<String, dynamic> chapter}) async {
    try {
      if (chapter["chapter_api_data"] != null) {
        var response = await dioConfig.dio.get(chapter["chapter_api_data"]);
        if (response.statusCode == 200) {
          var data = response.data["data"];
          ChapterModel chapterModel = ChapterModel.fromJson(data);
          return Result.success(chapterModel);
        } else {
          return Result.error(ApiError.unknown);
        }
      }
      return Result.error(ApiError.unknown);
    } catch (e) {
      return Result.error(ApiError.unknown);
    }
  }

  // Xử lý lỗi API
  Result<T> _handleApiError<T>(e) {
    if (e is DioException) {
      if (e.response?.statusCode == 401) {
        return Result.error(ApiError.unauthorized);
      }
    }
    return Result.error(ApiError.unknown);
  }

}
