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

  var currentTypePageNovel = 0.obs;

  var currentIndexCategory = 0.obs;

  var currentIndexCategoryNovel = 0.obs;

  var currentCategoryModalNovel = 0.obs;

  var currentCategoryModal = 0.obs;

  var isLoading = false.obs;

  var hasMore = true.obs;

  var currentPage = 2.obs;

  ComicApi comicApi = ComicApi();

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
  Rx<ListComicModel> dataComicCategoryByTypeAndStatus =
      ListComicModel(titlePage: '', domainImage: "", items: []).obs;

  RxList<NovelResponse> listNovel = <NovelResponse>[].obs;

  RxList<NovelResponse> listNovelComplete = <NovelResponse>[].obs;

  final ScrollController scrollController = ScrollController();

  String currentSlugComic = '';

  String currentSlugNovel = '';

  RxBool isDataLoading = false.obs;

  @override
  onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListener);
    await setCategoryCache();
    await fetchDataComicCategoryBySlug(slug: categories?[0].slug ?? "");
    currentSlugComic = categories?[0].slug ?? "";
    fetchDataNovelByCategory(categoryName: categoriesNovel[0].slug);
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
    isDataLoading.value = true;
    final result = await comicApi.fetchComicCategoryBySlug(slug: slug, page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        dataComicCategoryByType.value = apiResponse;
      }
    }
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
          await comicApi.fetchComicCategoryBySlug(slug: slug, page: page);
      if (result.status == Status.success) {
        final apiResponse = result.data;
        if (apiResponse != null) {
          completedComics.domainImage = apiResponse.domainImage;
          final filteredComics = apiResponse.items
              .where((item) => item.status == "completed")
              .toList();
          completedComics.items.addAll(filteredComics);

          if (filteredComics.isEmpty || apiResponse.items.length < 10) {
            hasMore.value = false;
            break;
          }
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

  Future<void> fetchListNovelByCategorySlugAndStatus(
      {required String status, required String categorySlug}) async {
    var result = await novelData.fetchListNovelByCategorySlugAndStatus(
        categorySlug: categorySlug, statusName: status);
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
    if (currentTypePageNovel.value == 0) {
      currentSlugNovel = categoryName;
      isDataLoading.value = true;
      var result =
          await novelData.fetchListNovelByCategory(statusName: categoryName);
      if (result.status == Status.success) {
        listNovel.value = result.data ?? [];
      }
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
      currentSlugComic = slug;
      update(['listComicId']);
    } else if (currentTypePage.value == 1) {
      hasMore.value = true;
      currentPage.value = 1;
      dataComicCategoryByTypeAndStatus.value.items.clear();
      isDataLoading.value = true;
      await fetchDataComicCategoryBySlugAndStatus(slug: slug);
      update(['listComicId']);
      currentSlugComic = slug;
      isDataLoading.value = false;
    }
  }

  Future<void> loadMoreData() async {
    isLoading.value = true;
    final result = await comicApi.fetchComicCategoryBySlug(
        slug: categories![currentIndexCategory.value].slug,
        page: currentPage.value);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        dataComicCategoryByType.value.items.addAll(apiResponse.items);
        update(['listComicId']);
        currentPage.value++;
        hasMore.value = apiResponse.items.isNotEmpty;
      } else {
        hasMore.value = false;
      }
    }
    isLoading.value = false;
  }
}
