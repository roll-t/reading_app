import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/core/utils/scroll_utils.dart';
import 'package:reading_app/features/dashboard/comic/domain/usecases/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/dashboard/comic/domain/usecases/fetch_home_data_usecase.dart';
import 'package:reading_app/features/dashboard/comic/domain/usecases/fetch_list_comic_by_status_usecase.dart';

class ComicController extends GetxController {
  final FetchHomeDataUsecase _fetchHomeDataUsecase;
  final FetchListComicByStatusUsecase _fetchComicByStatusUsecase;
  final FetchComicsByCategorySlugUsecase _fetchComicsByCategorySlugUsecase;
  final FetchCategoriesCacheUsecase _fetchCategoriesCacheUsecase;

  ComicController(
    this._fetchHomeDataUsecase,
    this._fetchCategoriesCacheUsecase,
    this._fetchComicByStatusUsecase,
    this._fetchComicsByCategorySlugUsecase,
  );

  // State variables
  final currentIndex = 0.obs;
  final isLoading = true.obs;
  final isLoadMore = false.obs;
  final isLoadProcessCategoryComics = false.obs;
  final isDataFetchedComplete = false.obs;

  RxList<ListComicModel> comicsByCategory = <ListComicModel>[].obs;
  RxList<CategoryModel>? categories;
  Rx<ListComicModel>? homeData;
  Rx<ListComicModel>? completedComics;
  Rx<ListComicModel>? selectedCategoryComics;

  final currentIndexCategory = 0.obs;
  RxList<NovelResponse> listSlide = <NovelResponse>[].obs;

  int currentPage = 1;

  final Set<int> usedCategoryIndexes = {}; //

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListening);
    await _initializeData();
    isLoading.value = false;
  }

  Future<void> _initializeData() async {
    homeData = (await _fetchHomeDataUsecase())?.obs;
    update(["listRecommendID"]);
    categories = (await _fetchCategoriesCacheUsecase())?.obs;
    completedComics =
        (await _fetchComicByStatusUsecase.call("hoan-thanh"))?.obs;
    update(["listCompleteID"]);
    if (categories?.isNotEmpty ?? false) {
      await fetchComicsForSelectedCategory(
          categories?[currentIndex.value].slug ?? "");
      update(["listCategoryID"]);
    }
  }

  Future<void> _scrollListening() async {
    var isAtBottom = ScrollUtils.isAtBottom(scrollController);
    if (isAtBottom) {
      if (categories?.isNotEmpty ?? false) {
        await fetchComicsByCategory();
      }
    }
  }

  // // Navigation
  // void navigateToCategoryDetail(String slug) {
  //   Get.toNamed(Routes.category, arguments: {"slugQuery": slug});
  // }

// Fetch Comics By Category
  Future<void> fetchComicsByCategory() async {
    if ((categories?.isEmpty ?? true) || isDataFetchedComplete.value) return;
    final maxIndex = categories?.length ?? 0;
    final selectedIndex = randomIndex(maxIndex);
    if (selectedIndex == null) {
      return;
    }
    isLoadMore.value = true;
    final selectedCategorySlug = categories?[selectedIndex].slug ?? "";
    final result =
        await _fetchComicsByCategorySlugUsecase.call(selectedCategorySlug);
    if (result != null) {
      comicsByCategory.add(result);
      update(["loadMoreComicsByCategoryID"]);
      if (ScrollUtils.isAtBottom(scrollController)) {
        ScrollUtils.scrollDown(scrollController, 100);
      }
    }
    isLoadMore.value = false;
  }

  // Fetch Comics By Selected Category
  Future<void> fetchComicsForSelectedCategory(String slug) async {
    isLoadProcessCategoryComics.value = true;
    selectedCategoryComics =
        (await _fetchComicsByCategorySlugUsecase.call(slug))?.obs;
    isLoadProcessCategoryComics.value = false;
  }

  List<ItemModel> getFirstNineItemsFromHome() {
    return homeData?.value.items.isNotEmpty ?? false
        ? homeData!.value.items.sublist(
            8,
            homeData!.value.items.length.clamp(8, 14),
          )
        : [];
  }

  // Get Slug by Title
  String getSlugByTitle(String title) {
    return categories?.firstWhere((category) => category.name == title).slug ??
        "";
  }

  int? randomIndex(int maxIndex) {
    if (usedCategoryIndexes.length >= maxIndex) {
      return null;
    }
    final random = Random();
    int index;
    do {
      index = random.nextInt(maxIndex);
    } while (usedCategoryIndexes.contains(index));
    usedCategoryIndexes.add(index);
    return index;
  }
}
