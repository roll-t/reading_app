import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_novel_by_category_slug_and_status_slug_usecase.dart';
import 'package:reading_app/features/content/explores/domain/usecase/fetch_novels_by_category_slug_usecase.dart';

class ExploreNovelTypeController extends GetxController
    with GetSingleTickerProviderStateMixin {
      
  final FetchNovelsByCategorySlugUsecase _fetchNovelsByCategorySlugUsecase;
  final FetchNovelByCategorySlugAndStatusSlugUsecase
      _fetchNovelByCategorySlugAndStatusSlug;

  ExploreNovelTypeController(
    this._fetchNovelByCategorySlugAndStatusSlug,
    this._fetchNovelsByCategorySlugUsecase,
  );

  RxBool isLoading = false.obs;

  RxBool isDataLoading = false.obs;

  RxBool isLoadMore = false.obs;

  RxBool hasMore = true.obs;

  RxInt currentTypePageNovel = 0.obs;

  RxInt currentIndexCategoryNovel = 0.obs;

  RxInt currentCategoryModalNovel = 0.obs;

  RxList<NovelResponse> listNovel = <NovelResponse>[].obs;

  RxList<NovelResponse> listNovelComplete = <NovelResponse>[].obs;

  late TabController tabController;

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
    await initial();
  }

  Future<void> initial() async {
    isDataLoading.value = true;
    await fetchDataNovelByCategory(categoryName: categoriesNovel[0].slug);
    isDataLoading.value = false;
  }

  void _handleTabChange() async {
    if (!tabController.indexIsChanging) {
      String newSlug = categoriesNovel[currentIndexCategoryNovel.value].slug;
      await fetchListNovelByCategorySlugAndStatus(
          categorySlug: newSlug, status: 'COMPLETED');
    }
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

  Future<void> fetchListNovelByCategorySlugAndStatus({
    required String status,
    required String categorySlug,
  }) async {
    isDataLoading.value = true;
    listNovelComplete.value = await _fetchNovelByCategorySlugAndStatusSlug(
            categorySlug: categorySlug, statusSlug: status) ??
        [];
    isDataLoading.value = false;
  }
}
