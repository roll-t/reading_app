import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/database/novel_data.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';

class CategoryNovelController extends GetxController {
  var title = "".obs;

  var isLoading = false.obs;

  var hasMore = true.obs;

  NovelData novelData = NovelData();

  var currentPage = 1.obs; // Start from the first page

  var typeOfList = [
    "truyen-moi",
    "sap-ra-mat",
    "dang-phat-hanh",
    "hoan-thanh"
  ]; // Novel categories

  RxList<NovelResponse> listDataChangeCategory = <NovelResponse>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;

    scrollController.addListener(_scrollListener);

    // Validate and process slugQuery
    if (Get.arguments["slugQuery"] != null &&
        Get.arguments["slugQuery"] is String) {
      var slug = Get.arguments["slugQuery"].trim();
      if (slug.isNotEmpty) {
        try {
          (slug: slug);
        } catch (e) {
          print("Error fetching data: $e");
        }
      } else {
        print("Slug is empty.");
      }
    } else {
      print("Invalid or missing slugQuery.");
    }

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

  Future<Result<List<NovelResponse>>> _routeRenderData({
    required String slug,
    required int page,
  }) {
    if (typeOfList.contains(slug)) {
      return novelData.fetchListNovel();
    }
    return novelData.fetchListNovelByStatus(statusName: "OPENING");
  }

  Future<void> fetchDataNovelCategoryByChange({required String slug}) async {
    final result = await _routeRenderData(slug: slug, page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataChangeCategory.value = apiResponse;
      }
    }
    update(["loadMoreID"]);
  }

  Future<void> fetchData() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      final result = await _routeRenderData(
        slug: Get.arguments["slugQuery"],
        page: currentPage.value,
      );

      if (result.status == Status.success) {
        final apiResponse = result.data;
        if (apiResponse != null && apiResponse.isNotEmpty) {
          // ignore: invalid_use_of_protected_member
          listDataChangeCategory.value.addAll(apiResponse); // Append new items
          currentPage.value++; // Increment page for next fetch
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
