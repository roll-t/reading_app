import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/service/data/api/database/novel_service.dart';
import 'package:reading_app/core/service/data/api/remote/comic_service.dart';
import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';

class FindController extends GetxController {
  dynamic argumentValue = Get.arguments["mark"];

  var isLoading = false.obs;
  var titlePage = "".obs;

  late final ComicApi comicApi;
  late final NovelData novelData;

  Rx<ListComicModel> listComicSearch = ListComicModel(
    domainImage: "",
    titlePage: '',
    items: [],
  ).obs;

  RxList<NovelResponse> listNovelSearch = <NovelResponse>[].obs;

  Timer? _debounce;

  final Map<String, ListComicModel> searchCache = {};

  final Map<String, List<NovelResponse>> searchNovelCache = {};

  @override
  void onInit() {
    super.onInit();
    comicApi = ComicApi();
    novelData = NovelData();
    fetchDefaultData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchDefaultData() async {
    _setLoading(true);
    if (argumentValue != null) {
      if (argumentValue == "COMIC") {
        final result = await comicApi.fetchListBySlug(slug: "Rồng", page: 1);
        if (result.data != null) {
          listComicSearch.value = result.data!;
        }
      }
      if (argumentValue == "NOVEL") {
        final result = await novelData.searchNovelByNameOrSlug(text: "so thu");
        if (result.data != null) {
          listNovelSearch.value = result.data!;
        }
      }
    }
    _setLoading(false);
  }

  void handleSearch({required String searchContent}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (searchContent.isEmpty || searchContent.length < 3) return;
    if (searchCache.containsKey(searchContent)) {
      listComicSearch.value = searchCache[searchContent]!;
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _setLoading(true);
      if (argumentValue != null) {
        if (argumentValue == "COMIC") {
          final result = await comicApi.fetchListSearchBySlug(
              slug: searchContent, page: 1);
          if (result.data != null) {
            listComicSearch.value = result.data!;
            searchCache[searchContent] = result.data!; // Lưu kết quả vào cache
          }
        }
        if (argumentValue == "NOVEL") {
          final result =
              await novelData.searchNovelByNameOrSlug(text: searchContent);
          if (result.data != null) {
            listNovelSearch.value = result.data!;
            searchNovelCache[searchContent] = result.data!;
          }
        }
      }
      _setLoading(false);
    });
  }

  void _setLoading(bool value) {
    isLoading.value = value;
  }
}
