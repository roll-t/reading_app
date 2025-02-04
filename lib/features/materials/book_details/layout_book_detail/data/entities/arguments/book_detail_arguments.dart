// ignore: file_names
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/data/entities/models/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book_details/novels/presentation/controller/novel_detail_controller.dart';

class BookDetailArguments {
  final String? uid;
  final NovelDetailController? novelDetailController;
  final ComicDetailController? comicDetailController;
  final RxBool isLoading;
  final InfoBookDetailModel infoBookDetailModel;
  final List<ChapterNovelModel> listChapter;
  final List<dynamic>? listChapterComic;
  final List<CategoryModel>? categories;
  final List<CategoryResponse>? categoriesNovel;
  final List<CommentResponse>? lisComment;
  final String? novelId;
  final String? comicId;

  BookDetailArguments({
    this.uid,
    this.novelDetailController,
    this.comicDetailController,
    required this.isLoading,
    required this.infoBookDetailModel,
    this.listChapterComic,
    this.categories,
    this.novelId,
    this.comicId,
    this.categoriesNovel,
    this.lisComment,
    this.listChapter = const <ChapterNovelModel>[],
  });
}
