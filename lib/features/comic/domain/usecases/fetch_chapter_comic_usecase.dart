import 'package:reading_app/core/services/entities/models/chapter_comic%20_model.dart';
import 'package:reading_app/features/comic/domain/repositories/comic_read_repository.dart';

class FetchChapterComicUsecase {
  final ComicReadRepository _readRepository;
  FetchChapterComicUsecase(this._readRepository);

  Future<ChapterComicModel?> call(Map<String, dynamic> chapter) async {
    return await _readRepository.fetchChapterComicUsecase(chapter);
  }
}
