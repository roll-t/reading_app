import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/data/api/database/comment_comic_service.dart';
import 'package:reading_app/core/service/data/api/remote/comic_service.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';

class ComicDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  dynamic argumentComicId = Get.arguments["comicId"];

  var isLoading = false.obs;

  ComicModel comicModel = ComicModel(title: "", description: "", thumb: "");

  List<dynamic> chapters = [];

  List<CategoryModel> category = [];

  List<String> listIntroduceSlide = [];

  List<dynamic> listComicNewest = [];

  String domainImage = "";

  dynamic slugArgument;

  CommentComicData commentComicData = CommentComicData();

  List<CommentResponse> listComment = [];

  RxBool isComicAvAilable = true.obs;

  ComicApi comicApi = ComicApi();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await initial();
    update(["body"]);
    isLoading.value = false;
  }

  initial() async {
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments["slug"] != null) {
        slugArgument = Get.arguments["slug"];
        await fetchDataAPI();
        await fetchAllComment();
      }
    }
  }

  Future<void> fetchAllComment() async {
    if (argumentComicId != null) {
      var response =
          await commentComicData.fetchAllComment(bookId: argumentComicId);
      if (response.status == Status.success) {
        listComment = response.data ?? [];
      }
    }
  }

  Future<void> loadComicDetail() async {
    await fetchAllComment();
    update(["body"]);
  }

  Future<void> fetchDataAPI() async {
    try {
      final result = await comicApi.fetchBookBySlug(slug: slugArgument);
      if (result.status == Status.success) {
        comicModel = result.data ?? ComicModel(title: "", description: "", thumb: "");
        chapters = comicModel.chapters ?? [];
        if (comicModel.category != null) {
          category = (comicModel.category as List<dynamic>)
              .map((item) => CategoryModel.fromJson(item))
              .toList();
        }
      } else {
        isComicAvAilable.value = false;
        SnackbarUtil.showInfo("Truyện bản quyền");
      }
    } catch (e) {
      print(e);
    }
  }
}
