import 'package:get/get.dart';
import 'package:reading_app/core/configs/default_data.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/chapter_data.dart';
import 'package:reading_app/core/database/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/database/data/model/novel_model.dart';
import 'package:reading_app/core/database/data/novel_data.dart';
import 'package:reading_app/core/routes/routes.dart';

class NovelDetailController extends GetxController {
  var isLoading = false.obs;
  NovelModel novelModel = DefaultData.defaultNovel;
  List<dynamic> chapters = [];
  dynamic slugArgument;
  List<ChapterNovelModel> listChapter = <ChapterNovelModel>[];

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments["novelId"] != null) {
        slugArgument = Get.arguments["novelId"];
      }
    }
    fetchDataAPI();
  }

  Future<void> fetchDataAPI() async {
    isLoading.value = true;
    try {
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
    } catch (e) {
      print(e);
    }

    update(["body"]);
    isLoading.value = false;
  }
}
