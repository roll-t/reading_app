import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/entities/models/chapter_comic%20_model.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_read_repository.dart';

class ComicReadRepositoryImpl implements ComicReadRepository {
  final ComicApi _comicService;

  ComicReadRepositoryImpl(this._comicService);

  @override
  Future<ChapterComicModel?> fetchChapterComicUsecase(
      Map<String, dynamic> chapter) async {
    try {
      var result = await _comicService.fetchChapterAPI(chapter: chapter);
      if (result.status == Status.success) {
        return result.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
