import 'package:reading_app/core/services/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class ChapterService extends ApiService {
  ChapterService(super.dioConfig, super.cacheService);



  Future<Result<List<ChapterNovelModel>>> fetchListChapterOfBook(
      {required String slug}) async {
    return await get(
        endpoint: APIEndpoint.getListChapterOfBookEndpoint(slug: slug),
        parse: (data) => (data as List<dynamic>)
            .map((item) => ChapterNovelModel.fromJson(item))
            .toList());
  }

  // static Future<Result<List<ChapterNovelModel>>> getListChapterOfBook(
  //     {required String slug}) {
  //   return ChapterService().fetchListChapterOfBook(slug: slug);
  // }
}
