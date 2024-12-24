import 'package:reading_app/core/service/configs/end_point_config.dart';
import 'package:reading_app/core/service/core_service.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class ChapterData extends CoreService {
  ChapterData._privateConstructor();

  static final ChapterData _instance = ChapterData._privateConstructor();

  factory ChapterData() {
    return _instance;
  }

  Future<Result<List<ChapterNovelModel>>> fetchListChapterOfBook(
      {required String slug}) async {
    return await fetchData(
        endpoint: EndPointSetting.getListChapterOfBookEndpoint(slug: slug),
        parse: (data) => (data as List<dynamic>)
            .map((item) => ChapterNovelModel.fromJson(item))
            .toList());
  }

  static Future<Result<List<ChapterNovelModel>>> getListChapterOfBook(
      {required String slug}) {
    return ChapterData().fetchListChapterOfBook(slug: slug);
  }
}
