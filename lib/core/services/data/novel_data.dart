import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/configs/dio_config.dart';
import 'package:reading_app/core/services/configs/end_point_setting.dart';
import 'package:reading_app/core/services/data/model/result.dart';
import 'package:reading_app/core/services/dto/response/novel_response.dart';

class NovelData {
  late DioConfig _dioConfig;

  NovelData() {
    _dioConfig = DioConfig(); // Khởi tạo DioConfig
  }

  Future<Result<List<NovelResponse>>> fetchListNovel() async {
    try {
      await _dioConfig.init();
      final response =
          await _dioConfig.dio.get(EndPointSetting.getListNovelEnpoint);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["result"];
        List<NovelResponse> novels = data.map((item) => NovelResponse.fromJson(item)).toList();
        return Result.success(novels);
      } else {
        return Result.error(ApiError.badRequest);
      }
    } catch (e) {
      return Result.error(ApiError.badRequest);
    }
  }

  static Future<Result<List<NovelResponse>>> getListNovel() async {
    final dataRemote = NovelData();
    return await dataRemote.fetchListNovel();
  }
}
