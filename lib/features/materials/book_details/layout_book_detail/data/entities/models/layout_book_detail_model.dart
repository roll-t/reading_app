import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/data/entities/models/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book_details/novels/presentation/controller/novel_detail_controller.dart';

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
