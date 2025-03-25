import 'package:reading_app/core/services/entities/models/novel_model.dart';
import 'package:reading_app/features/novel/domain/repositories/novel_detail_repository.dart';

class FetchNovelByIdUsecase {
  final NovelDetailRepository _repository;
  FetchNovelByIdUsecase(this._repository);

  Future<NovelModel?> call({required String novelId}) async {
    return await _repository.fetchNovelById(novelId: novelId);
  }
}
