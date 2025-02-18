import 'package:reading_app/core/services/api/data/entities/models/chapter_comic%20_model.dart';

abstract class ComicReadRepository {
  Future<ChapterComicModel?> fetchChapterComicUsecase(Map<String, dynamic> chapter);
}
