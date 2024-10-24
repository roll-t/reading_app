import 'package:get/get.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/category_data.dart';
import 'package:reading_app/core/data/database/chapter_data.dart';
import 'package:reading_app/core/data/database/model/chapter_novel_model.dart';
import 'package:reading_app/core/data/database/model/novel_model.dart';
import 'package:reading_app/core/data/database/novel_data.dart';
import 'package:reading_app/core/data/dto/response/category_response.dart';
import 'package:reading_app/core/routes/routes.dart';

class NovelDetailController extends GetxController {
  var isLoading = false.obs;
  NovelModel novelModel = DefaultData.defaultNovel;
  CategoryData categoryData = CategoryData();

  List<dynamic> chapters = [];
  dynamic slugArgument;
  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];
  RxList<CategoryResponse> categories = <CategoryResponse>[].obs;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments["novelId"] != null) {
        slugArgument = Get.arguments["novelId"];
      }
    }
    isLoading.value = true;
    await fetchDataAPI();
    await fetchCategories();
    update(["body"]);
    isLoading.value = false;
  }

  Future<void> fetchDataAPI() async {
    final result = await NovelData.getNovelById(id: slugArgument);
    if (result.status == Status.error) {
      Get.offAllNamed(Routes.login);
    }
    if (result.status == Status.success) {
      novelModel = result.data ?? DefaultData.defaultNovel;
      final chapters =
          await ChapterData.getListChapterOfBook(slug: novelModel.slug ?? "");
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
}
