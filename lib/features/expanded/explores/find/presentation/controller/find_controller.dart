import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/services/api/comic_api.dart';
import 'package:reading_app/core/services/data/model/list_comic_model.dart';
import 'package:reading_app/core/services/data/model/result.dart';

class FindController extends GetxController {
  var isLoading = false.obs;
  var titlePage = "".obs;

  Rx<ListComicModel> listComicSearch = ListComicModel(
    domainImage: "",
    titlePage: '',
    items: [],
  ).obs;

  Timer? _debounce;
  Map<String, ListComicModel> searchCache = {};  // Caching results

  @override
  void dispose() {
    // Hủy Timer khi widget bị hủy
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchDefaultData();
  }

  Future<void> fetchDefaultData() async {
    isLoading.value = true;
    Result<ListComicModel> result =
        await ComicApi.getListSearchBySlug(slug: "Rồng");
    if (result.data != null) {
      listComicSearch.value = result.data!;
    }
    isLoading.value = false;
  }

  Future<void> handleSearch({required String searchContent}) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (searchContent.isEmpty || searchContent.length < 3) return;
    if (searchCache.containsKey(searchContent)) {
      listComicSearch.value = searchCache[searchContent]!;
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isLoading.value = true;
      
      // Gọi API để tìm kiếm
      Result<ListComicModel> result =
          await ComicApi.getListSearchBySlug(slug: searchContent);
      
      if (result.data != null) {
        listComicSearch.value = result.data!;
        searchCache[searchContent] = result.data!;  // Lưu kết quả vào cache
      }
      isLoading.value = false;
    });
  }
}
