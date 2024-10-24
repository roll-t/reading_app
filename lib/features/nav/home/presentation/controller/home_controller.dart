import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/book_case_data.dart';
import 'package:reading_app/core/data/database/model/list_category_model.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/database/novel_data.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/data/service/api/comic_api.dart';
import 'package:reading_app/core/routes/routes.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  var currentIndexCategory = 0.obs;

  var isLoading = false.obs;

  String domainImage = "";

  List<dynamic> chapters = [];

  NovelData novelData = NovelData();

  ComicApi comicApi = ComicApi();

  BookCaseData bookCaseData = BookCaseData();

  Rx<ListComicModel> listDataComplete = Rx<ListComicModel>(
    ListComicModel(domainImage: "", titlePage: '', items: []),
  );

  RxList<NovelResponse> listNovel = <NovelResponse>[].obs;
  RxList<NovelResponse> listSlide = <NovelResponse>[].obs;
  // RxList<ReadingBookCaseResponse> listReadContinue =
  //     <ReadingBookCaseResponse>[].obs;

  List<ListCategoryModel>? categories;

  Map<String, dynamic>? auth;

  Rx<String> userName = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;

    await _initializeData();
    isLoading.value = false;
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _fetchAuthData(),
      _setCategoryCache(),
      _fetchDataListComplete(),
      _fetchListNovel(),
      _fetchListNovelByListSlug(),
    ]);
  }

  Future<void> _fetchAuthData() async {
    String? token = await AuthUseCase.getAuthToken();
    auth = JwtDecoder.decode(token);
    userName.value = auth?["displayName"];
    // var result =
    //     await bookCaseData.fetchAllReadingBookCase(uid: auth?["uid"] ?? "");
    // if (result.status == Status.success) {
    //   listReadContinue.value = result.data ?? [];
    // }
  }

  Future<void> _fetchListNovelByListSlug() async {
    const List<String> listSlug = [
      "so-thu-bi-an",
      "gia-toc-viridis",
      "ke-cuong-tin-tu-inh-huong",
      "me-tre-phu-thuy-cua-lao-ai",
      "the-gioi-ky-dieu-cua-mai-mai",
    ];

    Result result =
        await novelData.fetchListNovelByListSlugNovel(listSlug: listSlug);
    if (result.status == Status.success) {
      listSlide.value = result.data ?? [];
    }
  }

  Future<void> _setCategoryCache() async {
    await ComicApi.setCategoryCache();
    categories = await ComicApi.getCategoryCache();
  }

  Future<void> _fetchListNovel() async {
    Result result = await novelData.fetchListNovel();
    if (result.status == Status.success) {
      listNovel.value = result.data ?? [];
    }
  }

  Future<void> _fetchDataListComplete() async {
    final result = await comicApi.fetchListBySlug(page: 1, slug: 'sap-ra-mat');
    if (result.status == Status.success) {
      final apiResponse = result.data;

      if (apiResponse != null) {
        listDataComplete.value = apiResponse..titlePage = "Cập nhật mới nhất";
      }
    }
  }

  void toDetailListBySlug({required String slug}) {
    Get.toNamed(Routes.category, arguments: {"slugQuery": slug});
  }

  String getSlugByTitlePage({required String title}) {
    return categories?.firstWhere((category) => category.name == title).slug ??
        "";
  }
}
