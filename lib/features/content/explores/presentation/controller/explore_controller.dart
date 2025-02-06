import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/set_categories_cache_usecase.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_comics_by_category_slug_usecase.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_novel_by_category_slug_and_status_slug.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_novels_by_category_slug_usecase.dart';
import 'package:reading_app/features/content/explores/presentation/page/explore_comic_type_page.dart';
import 'package:reading_app/features/content/explores/presentation/page/explore_novel_type_page.dart';

class ExploreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FetchNovelsByCategorySlugUsecase _fetchNovelsByCategorySlugUsecase;
  final FetchNovelByCategorySlugAndStatusSlug
      _fetchNovelByCategorySlugAndStatusSlug;
  final SetCategoriesCacheUsecase _setCategoriesCacheUsecase;
  final FetchCategoriesCacheUsecase _fetchCategoriesCacheUsecase;
  final FetchComicsByCategorySlugUsecase _fetchComicsByCategorySlugUsecase;

  ExploreController(
    this._fetchNovelsByCategorySlugUsecase,
    this._fetchNovelByCategorySlugAndStatusSlug,
    this._setCategoriesCacheUsecase,
    this._fetchCategoriesCacheUsecase,
    this._fetchComicsByCategorySlugUsecase,
  );

  RxBool isLoading = false.obs;

  RxBool isDataLoading = false.obs;

  RxBool isLoadMore = false.obs;

  late TabController tabController;

  var currentTypePage = 0.obs;

  var currentTypePageNovel = 0.obs;

  var currentIndexCategory = 0.obs;

  var currentIndexCategoryNovel = 0.obs;

  var currentCategoryModalNovel = 0.obs;

  var currentCategoryModal = 0.obs;

  var hasMore = true.obs;

  var currentPage = 2.obs;

  RxString currentSlugComic = ''.obs;

  List<Widget> listPage = [
    const ExploreComicTypePage(),
    const ExploreNovelTypePage(),
  ];

  List<CategoryModel>? categories;

  Rx<ListComicModel> dataComicCategoryByType = ListComicModel(
    titlePage: '',
    domainImage: "",
    items: [],
  ).obs;

  Rx<ListComicModel> dataComicCategoryByTypeAndStatus = ListComicModel(
    titlePage: '',
    domainImage: "",
    items: [],
  ).obs;

  RxList<NovelResponse> listNovel = <NovelResponse>[].obs;

  RxList<NovelResponse> listNovelComplete = <NovelResponse>[].obs;

  final ScrollController scrollController = ScrollController();

  String currentSlugNovel = '';

  List<CategoryModel> categoriesNovel = [
    CategoryModel(id: '7', name: 'Action', slug: 'action'),
    CategoryModel(id: '8', name: 'Xuyên không', slug: 'xuyen-khong'),
    CategoryModel(id: '9', name: 'Trinh thám', slug: 'trinh-tham'),
    CategoryModel(id: '10', name: 'Thần thoại', slug: 'than-thoai'),
    CategoryModel(id: '12', name: 'Ngôn tình', slug: 'ngon-tinh'),
    CategoryModel(id: '13', name: 'Adult', slug: 'adult'),
    CategoryModel(
        id: '14', name: 'Ngôn tình tổng tài', slug: 'ngon-tinh-tong-tai'),
    CategoryModel(id: '15', name: 'Ngôn tình sắc', slug: 'ngon-tinh-sac'),
    CategoryModel(id: '16', name: 'Nữ cường', slug: 'nu-cuong'),
    CategoryModel(id: '17', name: 'Cổ đại', slug: 'co-ai'),
    CategoryModel(id: '18', name: 'Tiểu thuyết', slug: 'tieu-thuyet'),
    CategoryModel(id: '19', name: 'Hài hước', slug: 'hai-huoc'),
    CategoryModel(id: '20', name: 'Học đường', slug: 'hoc-uong'),
    CategoryModel(id: '21', name: 'Cung đấu', slug: 'cung-au'),
    CategoryModel(id: '23', name: 'Lịch sử', slug: 'lich-su'),
  ];

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
    fetchDataNovelByCategory(categoryName: categoriesNovel[0].slug);
    currentSlugComic.value = categories?[0].slug ?? "";
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
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

  void _handleTabChange() async {
    if (!tabController.indexIsChanging) {
      currentTypePage.value = tabController.index;
      await changeCategoryList(slug: currentSlugComic.value);
    }
  }

  Future<void> setCategoryCache() async {
    await _setCategoriesCacheUsecase();
    categories = await _fetchCategoriesCacheUsecase();
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

  Future<void> fetchListNovelByCategorySlugAndStatus({
    required String status,
    required String categorySlug,
  }) async {
    listNovelComplete.value = await _fetchNovelByCategorySlugAndStatusSlug(
            categorySlug: categorySlug, statusSlug: status) ??
        [];
  }

  Future<void> fetchDataNovelByCategory({required String categoryName}) async {
    if (currentTypePageNovel.value == 0) {
      currentSlugNovel = categoryName;
      isDataLoading.value = true;
      listNovel.value =
          await _fetchNovelsByCategorySlugUsecase(slug: categoryName) ?? [];
      isDataLoading.value = false;
    } else if (currentTypePageNovel.value == 1) {
      isDataLoading.value = true;
      await fetchListNovelByCategorySlugAndStatus(
          categorySlug: categoryName, status: 'COMPLETED');
      currentSlugNovel = categoryName;
      isDataLoading.value = false;
    }
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

  Future<void> loadMoreData() async {
    isLoadMore.value = true;
    final result = await _fetchComicsByCategorySlugUsecase(
        slug: categories![currentIndexCategory.value].slug,
        page: currentPage.value);
    if (result != null) {
      dataComicCategoryByType.value.items.addAll(result.items);
      currentPage.value++;
      hasMore.value = result.items.isNotEmpty;
    } else {
      hasMore.value = false;
    }
    isLoadMore.value = false;
  }
}
