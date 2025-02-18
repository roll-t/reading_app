import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/content/searches/domain/usecase/fetch_comics_default_search_usecase.dart';
import 'package:reading_app/features/content/searches/domain/usecase/fetch_comics_search_usecase.dart';

class SearchComicController extends GetxController {
  final FetchComicsDefaultSearchUsecase _fetchComicsDefaultSearchUsecase;
  final FetchComicsSearchUsecase _fetchComicsSearchUsecase;

  SearchComicController(
    this._fetchComicsDefaultSearchUsecase,
    this._fetchComicsSearchUsecase,
  );

  var isLoading = false.obs;
  var listComicSearch = Rx<ListComicModel?>(null);
  Timer? _debounce;

  final Map<String, ListComicModel> searchCache = {};

  @override
  void onInit() {
    super.onInit();
    fetchDefaultData();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> fetchDefaultData() async {
    isLoading.value = true;
    try {
      listComicSearch.value = await _fetchComicsDefaultSearchUsecase();
    } catch (e) {
      listComicSearch.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void handleSearch({required String searchContent}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (searchContent.isEmpty || searchContent.length < 3) {
      listComicSearch.value = null; // Xóa kết quả tìm kiếm nếu nhập quá ngắn
      return;
    }

    if (searchCache.containsKey(searchContent)) {
      listComicSearch.value = searchCache[searchContent];
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isLoading.value = true;
      try {
        final result =
            await _fetchComicsSearchUsecase(contentSearch: searchContent);
        if (result != null) {
          searchCache[searchContent] = result;
          listComicSearch.value = result;
        }
      } catch (e) {
        listComicSearch.value = null;
      } finally {
        isLoading.value = false;
      }
    });
  }
}
