import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/model/list_comic_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/service/api/comic_api.dart';
import 'package:reading_app/core/extensions/text_format.dart';

class CategoryController extends GetxController {
  Map<String, dynamic> dataArgument = Get.arguments;

  var title = "".obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var currentPage = 2.obs;

  var typeOfList = ["truyen-moi", "sap-ra-mat", "dang-phat-hanh", "hoan-thanh"];

  Rx<ListComicModel> listDataChangeCategory = ListComicModel(
    domainImage: "",
    titlePage: '',
    items: [],
  ).obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListener);
    if (dataArgument["slugQuery"] != null) {
      await fetchDataComicCategoryByChange(slug: dataArgument["slugQuery"]);
    }
    isLoading.value = false;
    update(["titleID", "ListCategoryID"]);
  }

  @override
  void onClose() {
    scrollController.dispose(); // Dispose of ScrollController
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasMore.value) {
        fetchData();
        update(["loadMoreID"]);
      }
    }
  }

  Future<Result<ListComicModel>> _routeRenderData(
      {required String slug, required page}) async {
    if (typeOfList.contains(slug)) {
      return await ComicApi.getListBySlug(slug: slug, page: page);
    }
    return await ComicApi.getListComicCategoryBySlug(slug: slug, page: page);
  }

  Future<void> fetchDataComicCategoryByChange({required String slug}) async {
    final result = await _routeRenderData(slug: slug, page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataChangeCategory.value = apiResponse;
        listDataChangeCategory.value.titlePage = TextFormat.capitalizeEachWord(
            listDataChangeCategory.value.titlePage);
      }
    }
    update(["loadMoreID"]);
  }

  Future<void> fetchData() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      final result = await _routeRenderData(
        slug: dataArgument["slugQuery"],
        page: currentPage.value,
      );

      if (result.status == Status.success) {
        final apiResponse = result.data;
        if (apiResponse != null && apiResponse.items.isNotEmpty) {
          listDataChangeCategory.value.items.addAll(apiResponse.items);
          currentPage.value++;
        } else {
          hasMore.value = false; // No more items to fetch
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
