import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/service/data/api/remote/comic_service.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class CategoryController extends GetxController {
  Map<String, dynamic> dataArgument = Get.arguments;

  var title = "".obs;

  var isLoading = false.obs;

  ComicApi comicApi = ComicApi();

  var hasMore = true.obs;

  var currentPage = 2.obs;

  var typeOfList = ["truyen-moi", "sap-ra-mat", "dang-phat-hanh", "hoan-thanh"];

  bool homeData = false;

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

    // Validate and process slugQuery
    if (dataArgument["slugQuery"] != null &&
        dataArgument["slugQuery"] is String) {
      var slug = dataArgument["slugQuery"].trim();
      if (slug.isNotEmpty) {
        try {
          await fetchDataComicCategoryByChange(slug: slug);
        } catch (e) {
          print("Error fetching data: $e");
        }
      } else {
        print("Slug is empty.");
      }
    } else {
      print("Invalid or missing slugQuery.");
    }

    // Finish loading and trigger UI update
    isLoading.value = false;
    update(["titleID", "ListCategoryID"]);
  }

  @override
  void onClose() {
    scrollController.dispose();
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
      {required String slug, required page}) {
    if (slug == "homeData") {
      homeData = true;
      return comicApi.fetchHomeData();
    }
    if (typeOfList.contains(slug)) {
      return comicApi.fetchListBySlug(slug: slug, page: page);
    }
    return comicApi.fetchComicCategoryBySlug(slug: slug, page: page);
  }

  Future<void> fetchDataComicCategoryByChange({required String slug}) async {
    final result = await _routeRenderData(slug: slug, page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataChangeCategory.value = apiResponse;
        if (homeData) {
          listDataChangeCategory.value.titlePage = "Truyện Nổi Bật";
        } else {
          listDataChangeCategory.value.titlePage =
              TextFormat.capitalizeEachWord(
                  listDataChangeCategory.value.titlePage);
        }
      }
    }
    update(["loadMoreID"]);
  }

  Future<void> fetchData() async {
    if (homeData) return;
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
