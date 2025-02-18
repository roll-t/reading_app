import 'dart:async';

import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/response_comic_api.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_comic%20_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/comic_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class ComicApi extends ApiService {
  ComicApi(super.dioConfig, super.cacheService);

  Future<Result<ComicModel>> fetchBookBySlug({required String slug}) async {
    return await get(
      endpoint: EndPointSetting.comicDetailEndpoint(slug: slug),
      parse: (data) => ComicModel.fromJson(data),
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy dữ liệu trang chủ
  Future<Result<ListComicModel>> fetchHomeData() async {
    return await get(
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
        
    var data = await get(
      endpoint: EndPointSetting.listByTypeEndpoint(slug: slug, page: page),
      parse: (data) =>
          ResponseComicApi.handleResponseData(200, data: data).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
    print(data.data);
    return data;
  }

  // Lấy danh sách tìm kiếm theo slug và trang
  Future<Result<ListComicModel>> fetchListSearchBySlug(
      {required String slug, required int page}) async {
    return await get(
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
    return await get(
      endpoint:
          EndPointSetting.categoriesBySlugEndpoint(slug: slug, page: page),
      parse: (data) =>
          ResponseComicApi.handleResponseData(200, data: data).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  // Lấy thông tin chapter của comic
  Future<Result<ChapterComicModel>> fetchChapterAPI(
      {required Map<String, dynamic> chapter}) async {
    try {
      if (chapter["chapter_api_data"] != null) {
        var response = await dioConfig.dio.get(chapter["chapter_api_data"]);
        if (response.statusCode == 200) {
          var data = response.data["data"];
          ChapterComicModel chapterModel = ChapterComicModel.fromJson(data);
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
}
