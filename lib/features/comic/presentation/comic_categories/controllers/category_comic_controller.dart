import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/core/utils/text_format.dart';
import 'package:reading_app/features/comic/data/entities/arguments/category_agrument.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_list_comic_by_status_usecase.dart';
import 'package:reading_app/features/comic/domain/usecases/fetch_recomendation_comic_usecase.dart';

///**********************************
/// CREATE TIME - 19/03/2025
///
/// **USED IN:**
/// - ` comic list`
///
/// **EXPLANATION:**
///  Display comic list by category and load more comic when load in last position page.
///*********************************/

class CategoryController extends GetxController {
  //---> define usecase variable
  final FetchRecommendationComicUsecase _fetchComicRecommendUsecase;
  final FetchComicsByCategorySlugUsecase _fetchComicsBySlugCategoryUsecase;
  final FetchListComicByStatusUsecase _fetchComicsByListStatusSlugUsecase;

  CategoryController(
    this._fetchComicRecommendUsecase,
    this._fetchComicsBySlugCategoryUsecase,
    this._fetchComicsByListStatusSlugUsecase,
  );

  late final CategoryArgument arguments;
  final ScrollController scrollController = ScrollController();

  //---> define RX variable
  var isLoading = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;
  var homeData = false;

  // Define list comic follow category
  var listComicFollowCategory = ListComicModel().obs;

  // define list comic status
  final List<String> typeOfList = [
    "truyen-moi",
    "sap-ra-mat",
    "dang-phat-hanh",
    "hoan-thanh",
    "de-xuat",
  ];

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await _initialize();
    isLoading.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  //---> init data value
  Future<void> _initialize() async {
    scrollController.addListener(_scrollListener);
    arguments = _getArguments();
    if (_isValidSlug(arguments.slug)) {
      await fetchData(
        slug: arguments.slug!.trim(),
      );
    }
  }

  CategoryArgument _getArguments() {
    return Get.arguments is CategoryArgument
        ? Get.arguments
        : CategoryArgument();
  }

  bool _isValidSlug(String? slug) => slug != null && slug.trim().isNotEmpty;

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasMore.value) {
        loadMoreComics();
      }
    }
  }

  //---> route between category type (status list, category type, recommend type)
  Future<ListComicModel?> _routeRenderData({
    required String slug,
    required int page,
  }) {
    if (slug == "de-xuat") {
      homeData = true;
      return _fetchComicRecommendUsecase();
    }
    if (typeOfList.contains(slug)) {
      return _fetchComicsByListStatusSlugUsecase(status: slug, page: page);
    }
    return _fetchComicsBySlugCategoryUsecase(slug: slug, page: page);
  }

  //---> call _routeRenderData fetch data base on incoming slug
  Future<void> fetchData({required String slug}) async {
    final result = await _routeRenderData(slug: slug, page: currentPage.value);
    if (result != null) {
      listComicFollowCategory.value = result;
      listComicFollowCategory.value.titlePage = homeData
          ? "Truyện Nổi Bật"
          : TextFormat.capitalizeEachWord(
              listComicFollowCategory.value.titlePage);
    }
  }

  //---> load more comics when scroll to last page position
  Future<void> loadMoreComics() async {
    if (homeData || isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    try {
      currentPage.value++;
      final result = await _routeRenderData(
          slug: arguments.slug ?? "", page: currentPage.value);
      if (result != null && result.items.isNotEmpty) {
        listComicFollowCategory.value.items.addAll(result.items);
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      log("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
