import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/novel_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/category_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/chapter_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/comment_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/repositories/novel_detail_repository.dart';

class NovelDetailRepositoryImpl implements NovelDetailRepository {
  final CommentService _commentService;
  final CategoryService _categoryService;
  final NovelService _novelService;
  final ChapterService _chapterService;

  NovelDetailRepositoryImpl(
    this._commentService,
    this._categoryService,
    this._novelService,
    this._chapterService,
  );

  @override
  Future<List<CommentResponse>?> fetchAlComment({
    required String novelId,
  }) async {
    try {
      var response = await _commentService.fetchAllComment(bookId: novelId);
      return response.status == Status.success ? response.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<CategoryResponse>?> fetchAllCategory() async {
    try {
      final categoryResponse = await _categoryService.fetchAllCategories();
      return categoryResponse.status == Status.success
          ? categoryResponse.data
          : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<ChapterNovelModel>?> fetchChaptersOfNovel({
    required String slug,
  }) async {
    try {
      final result = await _chapterService.fetchListChapterOfBook(slug: slug);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<NovelModel?> fetchNovelById({
    required String novelId,
  }) async {
    try {
      final result = await _novelService.fetchNovelById(id: novelId);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
