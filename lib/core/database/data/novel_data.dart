import 'package:reading_app/core/database/data/core_service.dart';
import 'package:reading_app/core/database/data/model/novel_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/dto/response/novel_response.dart';
import 'package:reading_app/core/database/service/configs/end_point_setting.dart';

class NovelData extends CoreService {
  
  NovelData._privateConstructor();
  static final NovelData _instance = NovelData._privateConstructor();
  factory NovelData() {
    return _instance;
  }

  Future<Result<List<NovelResponse>>> fetchListNovel() async {
    return await fetchData<List<NovelResponse>, List<NovelResponse>>(
      endpoint: EndPointSetting.getListNovelEnpoint,
      parse: (data) => (data as List<dynamic>)
          .map((item) => NovelResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<NovelModel>> fetchNovelById({required String id}) async {
    return await fetchData<NovelModel, NovelModel>(
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