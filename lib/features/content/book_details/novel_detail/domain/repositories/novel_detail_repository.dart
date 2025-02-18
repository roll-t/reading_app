import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/novel_model.dart';

abstract class NovelDetailRepository {
  Future<NovelModel?> fetchNovelById({required String novelId});
  Future<List<CategoryResponse>?> fetchAllCategory();
  Future<List<CommentResponse>?> fetchAlComment({required String novelId});
  Future<List<ChapterNovelModel>?> fetchChaptersOfNovel({required String slug});
}