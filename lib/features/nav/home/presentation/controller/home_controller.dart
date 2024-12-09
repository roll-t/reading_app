import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/database/book_case_service.dart';
import 'package:reading_app/core/service/api/database/novel_service.dart';
import 'package:reading_app/core/service/api/dto/response/novel_response.dart';
import 'package:reading_app/core/service/api/remote/comic_api.dart';
import 'package:reading_app/core/service/service/model/list_category_model.dart';
import 'package:reading_app/core/service/service/model/list_comic_model.dart';
import 'package:reading_app/core/service/service/model/result.dart';
import 'package:reading_app/core/service/service/model/user_model.dart';
import 'package:reading_app/core/storage/use_case/auth_use_case.dart';
import 'package:reading_app/core/storage/use_case/get_user_use_case.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  GetuserUseCase ? _getuserUseCase;

  // HomeController(this._getuserUseCase);
  
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

  RxList<ListCategoryModel> categories = <ListCategoryModel>[].obs;

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
      _fetchListSlider(),
      _fetchAuthData(),
      _setCategoryCache(),
    ]);

    _fetchDataListComplete();
    _fetchListNovel();
  }

  Future<void> _fetchAuthData() async {
    String? token = await AuthUseCase.getAuthToken();
    auth = JwtDecoder.decode(token);
    UserModel? userModel = await _getuserUseCase?.getUser();
    userName.value = userModel?.displayName ?? "username";
  }

  Future<void> _setCategoryCache() async {
    await ComicApi.setCategoryCache();
    categories.value = await ComicApi.getCategoryCache() ?? [];
  }

  Future<void> _fetchListNovel() async {
    Result result = await novelData.fetchListNovel();
    if (result.status == Status.success) {
      listNovel.value = result.data ?? [];
    }
  }

  Future<void> _fetchListSlider() async {
    Result result =
        await novelData.fetchListNovelByStatus(statusName: "SLIDER");
    if (result.status == Status.success) {
      listSlide.value = result.data ?? [];
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
    return categories.firstWhere((category) => category.name == title).slug;
  }
}
