import 'dart:developer';

import 'package:get/get.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/data/model/comic_detail_argument.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/domain/usecase/fetch_comic_by_slug_usecase.dart';
import 'package:reading_app/features/materials/book_details/comics/comic_detail/domain/usecase/fetch_comments_comic_usecase.dart';

class ComicDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FetchComicBySlugUsecase _fetchComicBySlugUsecase;
  final FetchCommentsComicUsecase _fetchCommentsComicUsecase;

  ComicDetailController(
    this._fetchComicBySlugUsecase,
    this._fetchCommentsComicUsecase,
  );

  RxBool isLoading = false.obs;
  RxBool isComicAvAilable = true.obs;

  late final ComicDetailArguments arguments;
  ComicModel? comicModel;

  List<dynamic> chapters = [];
  List<CategoryModel> category = [];
  List<dynamic> listComicNewest = [];
  List<CommentResponse> listComment = [];

  @override
  void onInit() async {
    super.onInit();
    arguments = _getArguments();
    isLoading.value = true;
    await _initial();
    isLoading.value = false;
  }

  Future<void> loadComment() async {
    await fetchCommentsComic();
  }

  Future<void> _initial() async {
    if (arguments.slug != null) {
      await fetchComicBySlug();
      await fetchCommentsComic();
    }
  }

  ComicDetailArguments _getArguments() {
    if (Get.arguments is Map<String, dynamic>) {
      return ComicDetailArguments.fromMap(Get.arguments);
    }
    return ComicDetailArguments();
  }

  Future<void> fetchCommentsComic() async {
    if (arguments.comicId != null) {
      var response =
          await _fetchCommentsComicUsecase.call(arguments.comicId ?? "");
      listComment = response;
    }
  }

  Future<void> fetchComicBySlug() async {
    try {
      final result = await _fetchComicBySlugUsecase(arguments.slug ?? "");
      if (result != null) {
        comicModel = result;
        chapters = comicModel?.chapters ?? [];
        if (comicModel?.category != null) {
          category = (comicModel?.category as List<dynamic>)
              .map((item) => CategoryModel.fromJson(item))
              .toList();
        }
      } else {
        isComicAvAilable.value = false;
        SnackbarUtil.showInfo("Truyện bản quyền");
      }
    } catch (e, stackTrace) {
      log("Lỗi khi tải truyện: $e", stackTrace: stackTrace);
    }
  }
}
