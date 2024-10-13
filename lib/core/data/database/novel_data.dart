import 'package:reading_app/core/data/database/model/novel_model.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class NovelData extends CoreService {
  NovelData._privateConstructor();
  static final NovelData _instance = NovelData._privateConstructor();
  factory NovelData() {
    return _instance;
  }

  Future<Result<List<NovelResponse>>> fetchListNovel() async {
    return await fetchData(
      endpoint: EndPointSetting.getListNovelEnpoint,
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<NovelModel>> fetchNovelById({required String id}) async {
    return await fetchData(
      endpoint: EndPointSetting.getNovelByIdEnpoint(id: id),
      parse: (data) => NovelModel.fromJson(data),
    );
  }

  // Static methods sử dụng singleton instance
  static Future<Result<List<NovelResponse>>> getListNovel() {
    return NovelData().fetchListNovel();
  }

  static Future<Result<NovelModel>> getNovelById({required String id}) {
    return NovelData().fetchNovelById(id: id);
  }
}
