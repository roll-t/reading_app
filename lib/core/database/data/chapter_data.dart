import 'package:reading_app/core/database/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/data/service_api.dart';
import 'package:reading_app/core/database/service/configs/end_point_setting.dart';

class ChapterData extends ServiceApi {
  
  ChapterData._privateConstructor();

  static final ChapterData _instance = ChapterData._privateConstructor();

  factory ChapterData() {
    return _instance;
  }

  Future<Result<List<ChapterNovelModel>>> fetchListChapterOfBook(
      {required String slug}) async {
    return await fetchData<List<ChapterNovelModel>, List<ChapterNovelModel>>(
        endpoint: EndPointSetting.getListChapterOfBookEndpoint(slug: slug),
        parse: (data) => (data as List<dynamic>)
            .map((item) => ChapterNovelModel.fromJson(item))
            .toList());
  }

  static Future<Result<List<ChapterNovelModel>>> getListChapterOfBook({required String slug}){
    return ChapterData().fetchListChapterOfBook(slug: slug);
  }
  
}
