import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/set_categories_cache_usecase.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_comics_by_category_slug_usecase.dart';

class ExploreComicTypeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final SetCategoriesCacheUsecase _setCategoriesCacheUsecase;
  final FetchCategoriesCacheUsecase _fetchCategoriesCacheUsecase;
  final FetchComicsByCategorySlugUsecase _fetchComicsByCategorySlugUsecase;

  ExploreComicTypeController(
    this._setCategoriesCacheUsecase,
    this._fetchCategoriesCacheUsecase,
    this._fetchComicsByCategorySlugUsecase,
  );
  RxBool isLoading = false.obs;

  RxBool isDataLoading = false.obs;

  RxBool isLoadMore = false.obs;

  late TabController tabController;

  var currentTypePage = 0.obs;

  var currentIndexCategory = 0.obs;

  var hasMore = true.obs;

  var currentPage = 2.obs;

  RxString currentSlugComic = ''.obs;

  var currentCategoryModal = 0.obs;

  final ScrollController scrollController = ScrollController();

  Rx<ListComicModel> dataComicCategoryByType = ListComicModel(
    titlePage: '',
    domainImage: "",
    items: [],
  ).obs;

  List<CategoryModel>? categories;

  Rx<ListComicModel> dataComicCategoryByTypeAndStatus = ListComicModel(
    titlePage: '',
    domainImage: "",
    items: [],
  ).obs;

  @override
  onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabChange);
    isLoading.value = true;
    await _initialize();
    isLoading.value = false;
  }

  Future<void> _initialize() async {
    scrollController.addListener(_scrollListener);
    await setCategoryCache();
    await fetchDataComicCategoryBySlug(slug: categories?[0].slug ?? "");
    currentSlugComic.value = categories?[0].slug ?? "";
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("loading");
      if (!isLoadMore.value && hasMore.value) {
        loadMoreData();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> changeCategoryList({required String slug}) async {
    if (currentTypePage.value == 0) {
      hasMore.value = true;
      currentPage.value = 1;
      dataComicCategoryByType.value.items.clear();
      await fetchDataComicCategoryBySlug(slug: slug);
      currentSlugComic.value = slug;
    } else if (currentTypePage.value == 1) {
      hasMore.value = true;
      currentPage.value = 1;
      dataComicCategoryByTypeAndStatus.value.items.clear();
      isDataLoading.value = true;
      await fetchDataComicCategoryBySlugAndStatus(slug: slug);
      currentSlugComic.value = slug;
      isDataLoading.value = false;
    }
  }

  void _handleTabChange() async {
    if (!tabController.indexIsChanging) {
      String newSlug = categories?[currentIndexCategory.value].slug ?? "";
      await fetchDataComicCategoryBySlugAndStatus(slug: newSlug);
    }
  }

  Future<void> fetchDataComicCategoryBySlugAndStatus(
      {required String slug}) async {
    isDataLoading.value = true;
    int page = 1;
    ListComicModel completedComics =
        ListComicModel(titlePage: '', domainImage: "", items: []);
    while (completedComics.items.length < 10 && hasMore.value) {
      final result =
          await _fetchComicsByCategorySlugUsecase(slug: slug, page: page);
      if (result != null) {
        completedComics.domainImage = result.domainImage;
        final filteredComics =
            result.items.where((item) => item.status == "completed").toList();
        completedComics.items.addAll(filteredComics);

        if (filteredComics.isEmpty || result.items.length < 10) {
          hasMore.value = false;
          break;
        }
      } else {
        hasMore.value = false;
        break;
      }
      page++;
    }
    dataComicCategoryByTypeAndStatus.value = ListComicModel(
      titlePage: "Hoàn thành",
      domainImage: completedComics.domainImage,
      items: completedComics.items,
    );
    isDataLoading.value = false;
  }

  Future<void> fetchDataComicCategoryBySlug({required String slug}) async {
    isDataLoading.value = true;
    dataComicCategoryByType.value =
        await _fetchComicsByCategorySlugUsecase(slug: slug, page: 1) ??
            ListComicModel(
              titlePage: '',
              domainImage: "",
              items: [],
            );
    isDataLoading.value = false;
  }

  Future<void> loadMoreData() async {
    print("loading");
    isLoadMore.value = true;
    final result = await _fetchComicsByCategorySlugUsecase(
        slug: categories![currentIndexCategory.value].slug,
        page: currentPage.value);
    if (result != null) {
      currentPage.value++;
      dataComicCategoryByType.value.items.addAll(result.items);
      hasMore.value = result.items.isNotEmpty;
    } else {
      hasMore.value = false;
    }
    isLoadMore.value = false;
  }

  Future<void> setCategoryCache() async {
    await _setCategoriesCacheUsecase();
    categories = await _fetchCategoriesCacheUsecase();
  }
}
