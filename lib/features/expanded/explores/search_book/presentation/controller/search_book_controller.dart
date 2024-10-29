import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/list_category_model.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/data/database/novel_data.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/data/service/api/comic_api.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/book_type_page.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/commic_type_page.dart';

class SearchBookController extends GetxController {

  NovelData novelData = NovelData();

  var currentTypePage = 0.obs;

  var currentIndexCategory = 0.obs;

  var currentIndexCategoryNovel = 0.obs;

  var currentCategoryModalNovel = 0.obs;

  var currentCategoryModal = 0.obs;

  var isLoading = false.obs;

  var hasMore = true.obs;

  var currentPage = 2.obs;

  List<Widget> listPage = [
    const CommicTypePage(),
    const BookTypePage(),
  ];

  List<ListCategoryModel>? categories;

  List<ListCategoryModel> categoriesNovel = [
    ListCategoryModel(id: '7', name: 'Action', slug: 'action'),
    ListCategoryModel(id: '8', name: 'Xuyên không', slug: 'xuyen-khong'),
    ListCategoryModel(id: '9', name: 'Trinh thám', slug: 'trinh-tham'),
    ListCategoryModel(id: '10', name: 'Thần thoại', slug: 'than-thoai'),
    ListCategoryModel(id: '12', name: 'Ngôn tình', slug: 'ngon-tinh'),
    ListCategoryModel(id: '13', name: 'Adult', slug: 'adult'),
    ListCategoryModel(
        id: '14', name: 'Ngôn tình tổng tài', slug: 'ngon-tinh-tong-tai'),
    ListCategoryModel(id: '15', name: 'Ngôn tình sắc', slug: 'ngon-tinh-sac'),
    ListCategoryModel(id: '16', name: 'Nữ cường', slug: 'nu-cuong'),
    ListCategoryModel(id: '17', name: 'Cổ đại', slug: 'co-ai'),
    ListCategoryModel(id: '18', name: 'Tiểu thuyết', slug: 'tieu-thuyet'),
    ListCategoryModel(id: '19', name: 'Hài hước', slug: 'hai-huoc'),
    ListCategoryModel(id: '20', name: 'Học đường', slug: 'hoc-uong'),
    ListCategoryModel(id: '21', name: 'Cung đấu', slug: 'cung-au'),
    ListCategoryModel(id: '23', name: 'Lịch sử', slug: 'lich-su'),
  ];

  Rx<ListComicModel> dataComicCategoryByType =
      ListComicModel(titlePage: '', domainImage: "", items: []).obs;

  RxList<NovelResponse> listNovel = <NovelResponse>[].obs;

  RxList<NovelResponse> listNovelComplete = <NovelResponse>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListener);
    await setCategoryCache();
    await fetchDataComicCategoryBySlug(slug: categories?[0].slug ?? "");
    Future.wait([
      fetchDataNovelByCategory(categoryName: categoriesNovel[0].slug),
      fetchListNovelByStatus(status: 'COMPLETED'),
    ]);
    isLoading.value = false;
    update(["IDSeach"]);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasMore.value) {
        loadMoreData();
        update(["UpdateListByCategory"]);
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> setCategoryCache() async {
    await ComicApi.setCategoryCache();
    categories = await ComicApi.getCategoryCache();
  }

  Future<void> fetchDataComicCategoryBySlug({required String slug}) async {
    final result =
        await ComicApi.getListComicCategoryBySlug(slug: slug, page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        dataComicCategoryByType.value = apiResponse;
      }
    }
  }

  Future<void> fetchListNovelByStatus({required String status}) async {
    var result = await novelData.fetchListNovelByStatus(statusName: status);
    if (result.status == Status.success) {
      listNovelComplete.value = result.data ?? [];
    }
  }

  Future<void> fetchDataNovelCategoryBySlug() async {
    var result = await novelData.fetchListNovel();
    if (result.status == Status.success) {
      listNovel.value = result.data ?? [];
    }
  }

  Future<void> fetchDataNovelByCategory({required String categoryName}) async {
    var result =
        await novelData.fetchListNovelByCategory(statusName: categoryName);
    if (result.status == Status.success) {
      listNovel.value = result.data ?? [];
    }
  }

  Future<void> changeCategoryList({required String slug}) async {
    await fetchDataComicCategoryBySlug(slug: slug);
    update(["UpdateListByCategory"]);
  }

  Future<void> loadMoreData() async {
    final result = await ComicApi.getListComicCategoryBySlug(
        slug: categories![currentIndexCategory.value].slug,
        page: currentPage.value);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        dataComicCategoryByType.value.items.addAll(apiResponse.items);
        currentPage.value++;
      } else {
        hasMore.value = false;
      }
    }
  }
}
