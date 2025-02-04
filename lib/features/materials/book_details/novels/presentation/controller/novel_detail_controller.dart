import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/locals/category_service.dart';
import 'package:reading_app/core/service/api/locals/chapter_service.dart';
import 'package:reading_app/core/service/api/locals/comment_service.dart';
import 'package:reading_app/core/service/api/locals/novel_service.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/data/model/novel_model.dart';
import 'package:reading_app/core/service/storage/use_case/auth_use_case.dart';

class NovelDetailController extends GetxController {
  var isLoading = false.obs;

  var isLoadingComment = false.obs;

  // define Object
  CommentService commentData = Get.find();
  CategoryService categoryData =Get.find();
  NovelService novelData =Get.find();
  ChapterService chapterService = Get.find();
  
  // define variable
  NovelModel novelModel = DefaultData.defaultNovel;
  List<dynamic> chapters = [];
  dynamic slugArgumentBookId;

  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];
  RxList<CategoryResponse> categories = <CategoryResponse>[].obs;
  RxList<CommentResponse> listComment = <CommentResponse>[].obs;

  dynamic authId;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments["novelId"] != null) {
        slugArgumentBookId = Get.arguments["novelId"];
      }
    }
    var token = await AuthUseCase.getAuthToken();
    authId = JwtDecoder.decode(token)["uid"];

    if (slugArgumentBookId != null) {
      isLoading.value = true;

      await fetchNovel();
      await fetchCategories();
      await fetchListComment(bookId: slugArgumentBookId);
      update(["body"]);
      isLoading.value = false;
    }
  }

  Future<void> fetchNovel() async {
    final result = await novelData.fetchNovelById(id: slugArgumentBookId);
    if (result.status == Status.error) {
      Get.offAllNamed(Routes.login);
    }
    if (result.status == Status.success) {
      novelModel = result.data ?? DefaultData.defaultNovel;
      final chapters = await chapterService.fetchListChapterOfBook(slug: novelModel.slug ?? "");
      if (chapters.status == Status.success) {
        listChapter = chapters.data ?? <ChapterNovelModel>[];
      }
    }
  }

  Future<void> fetchCategories() async {
    final categoryResponse = await categoryData.fetchAllCategories();
    if (categoryResponse.status == Status.success) {
      categories.value = categoryResponse.data ?? [];
      // ignore: invalid_use_of_protected_member
      categories.value = categories.value
          .where((category) =>
              novelModel.categorySlug?.contains(category.slug) ?? false)
          .toList();
    }
  }

  Future<void> fetchListComment({required String bookId}) async {
    var response = await commentData.fetchAllComment(bookId: bookId);
    if (response.status == Status.success) {
      listComment.value = response.data ?? [];
    }
  }

  Future<void> loadNovelDetails() async {
    await fetchListComment(bookId: slugArgumentBookId);
    update(["body"]);
  }
}
