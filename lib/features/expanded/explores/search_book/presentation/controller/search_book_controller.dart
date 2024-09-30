import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/model/list_category_model.dart';
import 'package:reading_app/core/database/data/model/list_comic_model.dart';
import 'package:reading_app/core/database/service/api/comic_api.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/book_type_page.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/commic_type_page.dart';

class SearchBookController extends GetxController {
  var currentIndexCategory = 0.obs;

  var currentCategoryModal=0.obs;

  var isLoading = false.obs;
  var hasMore = true.obs;
  var currentPage = 2.obs;

  List<Widget> listPage = [
    const CommicTypePage(),
    const BookTypePage(),
  ];

  List<ListCategoryModel>? categories;

  Rx<ListComicModel> dataComicCategoryByType =
      ListComicModel(titlePage: '', domainImage: "", items: []).obs;

  final ScrollController scrollController = ScrollController();

  @override
  onInit() async {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListener);
    await setCategoryCache();
    await fetchDataComicCategoryBySlug(slug: categories![0].slug);
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
    scrollController.dispose(); // Dispose of ScrollController
    super.onClose();
  }

  Future<void> setCategoryCache() async {
    await ComicApi.setCategoryCache();
    categories = await ComicApi.getCategoryCache();
  }

  Future<void> fetchDataComicCategoryBySlug({required String slug}) async {
    final result = await ComicApi.getListComicCategoryBySlug(slug: slug,page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        dataComicCategoryByType.value = apiResponse;
      }
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
