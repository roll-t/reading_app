import 'package:reading_app/core/service/data/model/chapter_model.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_read/domain/repositories/comic_read_repository.dart';

class FetchChapterComicUsecase {
  final ComicReadRepository _readRepository;
  FetchChapterComicUsecase(this._readRepository);

  Future<ChapterModel?> call(Map<String, dynamic> chapter) async {
    return await _readRepository.fetchChapterComicUsecase(chapter);
  }
}
