import 'dart:math';

import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/api/database/novel_service.dart';
import 'package:reading_app/core/service/data/api/remote/comic_service.dart';
import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';

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
    }
  }

  List<ItemModel> getFirstNineItemsFromHomeData() {
    const startIndex = 8;
    const endIndex = 14;
    if (homeData.value.items.isEmpty ||
        homeData.value.items.length <= startIndex) {
      return [];
    }
    return homeData.value.items.sublist(
      startIndex,
      homeData.value.items.length >= endIndex
          ? endIndex
          : homeData.value.items.length,
    );
  }

  Future<void> setCategoryCache() async {
    await ComicApi.setCategoryCache();
    // ignore: invalid_use_of_protected_member
    categories.value = await ComicApi.getCategoryCache() ?? categories.value;
  }

  Future<void> fetchDataComicCategoryBySlug() async {
    if (categories.isEmpty) return;

    final random = Random();
    final selectedIndexes = <int>{};
    while (selectedIndexes.length < 2 &&
        selectedIndexes.length < categories.length) {
      selectedIndexes.add(random.nextInt(categories.length));
    }

    for (var index in selectedIndexes) {
      final result = await comicApi.fetchComicCategoryBySlug(
        slug: categories[index].slug,
        page: 1,
      );

      if (result.status == Status.success) {
        final apiResponse = result.data;
        if (apiResponse != null) {
          listDataComicCategoryBySlug.value = [
            // ignore: invalid_use_of_protected_member
            ...listDataComicCategoryBySlug.value,
            apiResponse,
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
