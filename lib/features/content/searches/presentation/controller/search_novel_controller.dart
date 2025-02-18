import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/features/content/searches/domain/usecase/fetch_novel_search_usecase.dart';

class SearchNovelController extends GetxController {
  final FetchNovelSearchUsecase _fetchNovelSearchUsecase;

  SearchNovelController(this._fetchNovelSearchUsecase);

  var isLoading = false.obs;

  late final NovelService novelData;

  RxList<NovelResponse> listNovelSearch = <NovelResponse>[].obs;

  Timer? _debounce;

  final Map<String, ListComicModel> searchCache = {};

  final Map<String, List<NovelResponse>> searchNovelCache = {};

  @override
  void onInit() {
    super.onInit();
    novelData = Get.find();
    fetchDefaultData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchDefaultData() async {
    isLoading.value = true;
    listNovelSearch.value =
        await _fetchNovelSearchUsecase(contentSearch: "so thu") ?? [];
    isLoading.value = false;
  }

  void handleSearch({required String searchContent}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (searchContent.isEmpty || searchContent.length < 3) return;
    if (searchCache.containsKey(searchContent)) {
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isLoading.value = true;
      listNovelSearch.value =
          await _fetchNovelSearchUsecase(contentSearch: "so thu") ?? [];
      // ignore: invalid_use_of_protected_member
      searchNovelCache[searchContent] = listNovelSearch.value;
      isLoading.value = false;
    });
  }
}
