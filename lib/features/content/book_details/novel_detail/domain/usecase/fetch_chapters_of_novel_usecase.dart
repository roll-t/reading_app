import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/repositories/novel_detail_repository.dart';

class FetchChaptersOfNovelUsecase {
  final NovelDetailRepository _repository;
  FetchChaptersOfNovelUsecase(this._repository);

  Future<List<ChapterNovelModel>?> call({required String slug}) async {
    return await _repository.fetchChaptersOfNovel(slug: slug);
  }
}
