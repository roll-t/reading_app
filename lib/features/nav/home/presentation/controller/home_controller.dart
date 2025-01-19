import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/service/domain/usecase/categories/fetch_categories_cache_usecase.dart';
import 'package:reading_app/features/nav/home/domain/usecase/fetch_auth_usecase.dart';
import 'package:reading_app/features/nav/home/domain/usecase/fetch_novels_usecase.dart';
import 'package:reading_app/features/nav/home/domain/usecase/fetch_slider_usecase.dart';
import 'package:reading_app/features/nav/home/domain/usecase/fetch_up_coming_comics_usecase.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  final FetchAuthUsecase _fetchAuthUsecase;
  final FetchSliderUsecase _fetchSliderUsecase;
  final FetchUpComingComicsUsecase _fetchUpComingComicsUsecase;
  final FetchNovelsUsecase _fetchNovelsUsecase;
  final FetchCategoriesCacheUsecase _fetchCategoriesCacheUsecase;

  HomeController(
      this._fetchAuthUsecase,
      this._fetchSliderUsecase,
      this._fetchUpComingComicsUsecase,
      this._fetchNovelsUsecase,
      this._fetchCategoriesCacheUsecase);

  var isLoading = false.obs;
  var isLoadMore = false.obs;

  String domainImage = "";
  List<dynamic> chapters = [];
  Rx<ListComicModel>? upcomingComics;
  RxList<NovelResponse> listNovel = <NovelResponse>[].obs;
  RxList<NovelResponse> listSlide = <NovelResponse>[].obs;
  RxList<ListCategoryModel> categories = <ListCategoryModel>[].obs;
  Rx<UserModel> user = UserModel(email: "").obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await _initializeData();
    isLoading.value = false;
  }

  Future<void> _initializeData() async {
    _fetchListSlider();
    _fetchAuthData();
    _fetchUpComingComics();
    _fetchCategories();
    _fetchListNovel();
  }

  Future<void> _fetchAuthData() async {
    user.value = await _fetchAuthUsecase();
  }

  Future<void> _fetchListNovel() async {
    listNovel.value = await _fetchNovelsUsecase() ?? [];
  }

  Future<void> _fetchListSlider() async {
    listSlide.value = await _fetchSliderUsecase() ?? [];
  }

  Future<void> _fetchUpComingComics() async {
    upcomingComics = (await _fetchUpComingComicsUsecase())?.obs;
    update(["listComics"]);
  }

  Future<void> _fetchCategories() async {
    categories.value = await _fetchCategoriesCacheUsecase() ?? [];
  }

  void toDetailListBySlug({required String slug}) {
    Get.toNamed(Routes.category, arguments: {"slugQuery": slug});
  }
}
