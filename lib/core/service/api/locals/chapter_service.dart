import 'package:reading_app/core/configs/end_point_config.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class ChapterService extends ApiService {
  ChapterService(super.dioConfig, super.cacheService);



  Future<Result<List<ChapterNovelModel>>> fetchListChapterOfBook(
      {required String slug}) async {
    return await fetchData(
        endpoint: EndPointSetting.getListChapterOfBookEndpoint(slug: slug),
        parse: (data) => (data as List<dynamic>)
            .map((item) => ChapterNovelModel.fromJson(item))
            .toList());
  }

  // static Future<Result<List<ChapterNovelModel>>> getListChapterOfBook(
  //     {required String slug}) {
  //   return ChapterService().fetchListChapterOfBook(slug: slug);
  // }
}
