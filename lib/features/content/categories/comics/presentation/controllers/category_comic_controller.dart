import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/content/categories/comics/data/models/category_arument_model.dart';
import 'package:reading_app/features/content/categories/comics/domain/usecase/fetch_comic_recommend_usecase.dart';
import 'package:reading_app/features/content/categories/comics/domain/usecase/fetch_comics_by_slug_category_usecase.dart';
import 'package:reading_app/features/content/categories/comics/domain/usecase/fetch_comics_by_slug_usecase.dart';

class CategoryController extends GetxController {
  final FetchComicRecommendUsecase _fetchComicRecommendUsecase;
  final FetchComicsBySlugCategoryUsecase _fetchComicsBySlugCategoryUsecase;
  final FetchComicsBySlugUsecase _fetchComicsBySlugUsecase;

  late final CategoryArgumentModel arguments;
  final ScrollController scrollController = ScrollController();

  CategoryController(
    this._fetchComicRecommendUsecase,
    this._fetchComicsBySlugCategoryUsecase,
    this._fetchComicsBySlugUsecase,
  );

  var isLoading = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;
  var homeData = false;

  var listDataChangeCategory = ListComicModel(
    titlePage: '',
    items: [],
  ).obs;

  final List<String> typeOfList = [
    "truyen-moi",
    "sap-ra-mat",
    "dang-phat-hanh",
    "hoan-thanh",
    "de-xuat"
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

  Future<void> _initialize() async {
    scrollController.addListener(_scrollListener);
    arguments = _getArguments();
    if (_isValidSlug(arguments.slug)) {
      await fetchData(slug: arguments.slug!.trim());
    }
  }

  CategoryArgumentModel _getArguments() {
    return Get.arguments is CategoryArgumentModel
        ? Get.arguments
        : CategoryArgumentModel();
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

  Future<ListComicModel?> _routeRenderData({
    required String slug,
    required int page,
  }) {
    if (slug == "de-xuat") {
      homeData = true;
      return _fetchComicRecommendUsecase();
    }
    if (typeOfList.contains(slug)) {
      return _fetchComicsBySlugUsecase(slug: slug, page: page);
    }
    return _fetchComicsBySlugCategoryUsecase(slug: slug, page: page);
  }

  Future<void> fetchData({required String slug}) async {
    final result = await _routeRenderData(slug: slug, page: 1);
    if (result != null) {
      listDataChangeCategory.value = result;
      listDataChangeCategory.value.titlePage = homeData
          ? "Truyện Nổi Bật"
          : TextFormat.capitalizeEachWord(
              listDataChangeCategory.value.titlePage);
    }
  }

  Future<void> loadMoreComics() async {
    if (homeData || isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    try {
      final result = await _routeRenderData(
          slug: arguments.slug ?? "", page: currentPage.value);
      if (result != null && result.items.isNotEmpty) {
        listDataChangeCategory.value.items.addAll(result.items);
        currentPage.value++;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
