import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/list_category_model.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/data/database/novel_data.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/data/service/api/comic_api.dart';
import 'package:reading_app/core/routes/routes.dart';

class CommicController extends GetxController {
  var currentIndex = 0.obs;
  var isLoading = false.obs;
  NovelData novelData = NovelData();
  ComicApi comicApi = ComicApi();

  RxList<ListComicModel> listDataComicCategoryBySlug = <ListComicModel>[].obs;

  RxList<ListCategoryModel> categories = <ListCategoryModel>[].obs;

  Rx<ListComicModel> homeData =
      ListComicModel(domainImage: "", titlePage: '', items: []).obs;

  Rx<ListComicModel> listDataChangeCategory =
      ListComicModel(domainImage: "", titlePage: '', items: []).obs;
  Rx<ListComicModel> listCommitComplete =
      ListComicModel(domainImage: "", titlePage: '', items: []).obs;
  var currentIndexCategory = 0.obs;
  RxList<NovelResponse> listSlide = <NovelResponse>[].obs;

  @override
  onInit() async {
    super.onInit();
    isLoading.value = true;
    await setCategoryCache();
    await fetchListHome();
    if (categories.isNotEmpty) {
      fetchDataComicCategoryByChange(slug: categories[0].slug);
      fetchDataComicCategoryBySlug();
    }
    fetchListComplete();
    isLoading.value = false;
    update(["ListComicCategoryID"]);
  }

  void toDetailListBySlug({required String slug}) {
    Get.toNamed(Routes.category, arguments: {"slugQuery": slug});
  }

  Future<void> fetchListComplete() async {
    var response = await comicApi.fetchListBySlug(page: 2, slug: 'hoan-thanh');
    if (response.status == Status.success) {
      listCommitComplete.value = response.data ?? listCommitComplete.value;
    }
  }

  Future<void> fetchListHome() async {
    var response = await comicApi.fetchHomeData();
    if (response.status == Status.success) {
      homeData.value = response.data ?? listCommitComplete.value;
      homeData.value.titlePage = "Nổi bật";
    }
  }

  List<ItemModel> getFirstNineItemsFromHomeData() {
    if (homeData.value.items.length >= 13) {
      return homeData.value.items.sublist(10, 13);
    } else if (homeData.value.items.length > 10) {
      return homeData.value.items.sublist(10);
    } else {
      return [];
    }
  }

  Future<void> setCategoryCache() async {
    await ComicApi.setCategoryCache();
    categories.value = await ComicApi.getCategoryCache() ?? categories.value;
  }

  Future<void> fetchDataComicCategoryBySlug() async {
    for (var i = 10; i <= 11; i++) {
      final result = await comicApi.fetchComicCategoryBySlug(
          slug: categories[i].slug, page: 1);
      if (result.status == Status.success) {
        final apiResponse = result.data;
        if (apiResponse != null) {
          // ignore: invalid_use_of_protected_member
          listDataComicCategoryBySlug.value = [
            ...listDataComicCategoryBySlug.value,
            apiResponse
          ];
        }
      }
    }
  }

  String getSlugByTitlePage({required String title}) {
    ListCategoryModel? category = categories.firstWhere(
      (category) => category.name == title,
    );
    return category.slug;
  }

  Future<void> fetchDataComicCategoryByChange({required String slug}) async {
    try {
      final result =
          await comicApi.fetchComicCategoryBySlug(slug: slug, page: 1);
      if (result.status == Status.success && result.data != null) {
        listDataChangeCategory.value = result.data!;
      }
    } catch (e) {
      print("Error fetching category data: $e");
    }
    update(["ListCategory"]);
  }
}
