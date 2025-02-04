import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';

class CategoryNovelController extends GetxController {
  var title = "".obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;
  var listDataChangeCategory = <NovelResponse>[].obs;

  final NovelService novelData = Get.find();
  final ScrollController scrollController = ScrollController();
  final List<String> typeOfList = [
    "truyen-moi",
    "sap-ra-mat",
    "dang-phat-hanh",
    "hoan-thanh"
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    _initializeData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.atEdge &&
        scrollController.position.pixels != 0) {
      if (!isLoading.value && hasMore.value) {
        fetchData();
      }
    }
  }

  Future<void> _initializeData() async {
    isLoading.value = true;
    final categoryArgument = Get.arguments["slugQuery"] as CategoryResponse?;
    final slug = categoryArgument?.slug.trim();
    title.value=categoryArgument?.name.trim()??"Tiểu thuyết";
    if (slug != null && slug.isNotEmpty) {
      await _fetchInitialData(slug);
    } else {
      print(slug == null ? "Missing slugQuery" : "Slug is empty.");
    }

    isLoading.value = false;
    update(["titleID", "ListCategoryID"]);
  }

  Future<void> _fetchInitialData(String slug) async {
    try {
      await fetchDataNovelCategoryByChange(slug: slug);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<Result<List<NovelResponse>>> _routeRenderData({
    required String slug,
    required int page,
  }) {
    return typeOfList.contains(slug)
        ? novelData.fetchListNovelByStatus(statusName: "OPENING")
        : novelData.fetchListNovelByCategory(statusName: slug);
  }

  Future<void> fetchDataNovelCategoryByChange({required String slug}) async {
    final result = await _routeRenderData(slug: slug, page: 1);
    if (result.status == Status.success) {
      listDataChangeCategory.value = result.data ?? [];
    }
    update(["loadMoreID"]);
  }

  Future<void> fetchData() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      var value = Get.arguments["slugQuery"] as CategoryResponse;
      final result = await _routeRenderData(
        slug: value.slug,
        page: currentPage.value,
      );

      if (result.status == Status.success) {
        final apiResponse = result.data;

        if (apiResponse != null && apiResponse.isNotEmpty) {
          listDataChangeCategory.addAll(apiResponse);
          currentPage.value++;
        } else {
          hasMore.value = false;
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
