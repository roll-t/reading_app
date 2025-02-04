import 'package:reading_app/core/service/data/model/chapter_model.dart';

abstract class ComicReadRepository {
  Future<ChapterModel?> fetchChapterComicUsecase(Map<String, dynamic> chapter);
}
