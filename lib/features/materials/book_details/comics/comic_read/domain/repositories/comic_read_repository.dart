import 'package:reading_app/core/services/api/data/entities/models/chapter_model.dart';

abstract class ComicReadRepository {
  Future<ChapterModel?> fetchChapterComicUsecase(Map<String, dynamic> chapter);
}
