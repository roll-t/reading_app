import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/novel_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class NovelService extends ApiService {
  NovelService(super.dioConfig, super.cacheService);


  Future<Result<List<NovelResponse>>> fetchListNovel() async {
    return await get(
      useCache: true,
      endpoint: EndPointSetting.getListNovelEnpoint,
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<List<NovelResponse>>> fetchListNovelByStatus(
      {required String statusName}) async {
    return await get(
      useCache: true,
      endpoint: EndPointSetting.getNovelByStatus(statusName: statusName),
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<List<NovelResponse>>> searchNovelByNameOrSlug(
      {required String text}) async {
    return await get(
      useCache: true,
      endpoint: EndPointSetting.searchNovelByNameOrSlug(text: text),
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<List<NovelResponse>>> fetchListNovelByCategory(
      {required String statusName}) async {
    return await get(
      useCache: true,
      endpoint: EndPointSetting.getNovelByCategory(categoryName: statusName),
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  // trả về danh sách truyện dựa trên mảng slug
  Future<Result<List<NovelResponse>>> fetchListNovelByListSlugNovel(
      {required List<String> listSlug}) async {
    return await get(
      useCache: true,
      endpoint: EndPointSetting.getNovelByListSlug(listSlug: listSlug),
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  // trả về danh sách truyện dựa trên mảng slug
  Future<Result<List<NovelResponse>>> fetchListNovelByCategorySlugAndStatus(
      {required String categorySlug,
      String status = "COMPLETED",
      int page = 0,
      int size = 20,
      required String statusName}) async {
    return await get(
      endpoint: EndPointSetting.getNovelByCategoryAndStatus(
          categorySlug: categorySlug, status: status, page: page, size: size),
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<NovelModel>> fetchNovelById({required String id}) async {
    return await get(
      useCache: true,
      endpoint: EndPointSetting.getNovelByIdEnpoint(id: id),
      parse: (data) => NovelModel.fromJson(data),
    );
  }

  // // Static methods sử dụng singleton instance
  // static Future<Result<List<NovelResponse>>> getListNovel() {
  //   return NovelData().fetchListNovel();
  // }

  // static Future<Result<NovelModel>> getNovelById({required String id}) {
  //   return NovelData().fetchNovelById(id: id);
  // }

  // static Future<Result<List<NovelResponse>>> getNovelByStatus(
  //     {required String statusName}) {
  //   return NovelData().fetchListNovelByStatus(statusName: statusName);
  // }
}
