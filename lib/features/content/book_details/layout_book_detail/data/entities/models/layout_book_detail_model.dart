import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/features/content/book_details/comics/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/content/book_details/layout_book_detail/data/entities/models/info_book_detail_model.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/novel_detail_controller.dart';

class LayoutBookDetailModel {
  final String? uid;
  final NovelDetailController? novelDetailController;
  final ComicDetailController? comicDetailController;
  final RxBool isLoading;
  final InfoBookDetailModel infoBookDetailModel;
  final List<ChapterNovelModel> listChapter;
  final List<dynamic>? listChapterComic;
  final List<CategoryModel>? categories;
  final List<CategoryResponse>? categoriesNovel;
  final List<CommentResponse>? listComment;
  final String? novelId;
  final String? comicId;

  LayoutBookDetailModel({
    this.uid,
    this.novelDetailController,
    this.comicDetailController,
    required this.isLoading,
    required this.infoBookDetailModel,
    required this.listChapter,
    this.listChapterComic,
    this.categories,
    this.categoriesNovel,
    this.listComment,
    this.novelId,
    this.comicId,
  });
}
