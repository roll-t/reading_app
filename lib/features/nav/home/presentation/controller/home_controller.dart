import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/model/list_category_model.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/database/novel_data.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/data/service/api/comic_api.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/routes/routes.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  var currentIndexCategory = 0.obs;

  var isLoading = false.obs;

  String domainImage = "";

  List<dynamic> chapters = [];

  List<String> listIntroduceSlide = [];

  ListComicModel listDataSlider =
      ListComicModel(domainImage: "", titlePage: '', items: []);

  ListComicModel listDataComplete =
      ListComicModel(domainImage: "", titlePage: '', items: []);

  ListComicModel listDataComingSoon =
      ListComicModel(domainImage: "", titlePage: '', items: []);

  ListComicModel listDataNowRelease =
      ListComicModel(domainImage: "", titlePage: '', items: []);

  ListComicModel listDataNewUpdate =
      ListComicModel(domainImage: "", titlePage: '', items: []);

  ListComicModel listDataChangeCategory =
      ListComicModel(domainImage: "", titlePage: '', items: []);

  List<ListComicModel> listDataComicCategoryBySlug = <ListComicModel>[];

  List<NovelResponse> listNovel = <NovelResponse>[];

  List<ListCategoryModel>? categories;

  @override
  onInit() async {
    super.onInit();

    isLoading.value = true;

    await Future.wait([
      fetchDataHomeApi(),
      setCategoryCache(),
      fetchDataListComplete(),
      fetchDataListNewUpdate(),
      fetchListNovel(),
    ]);

    if (categories != null && categories!.isNotEmpty) {
      await Future.wait([
        fetchDataComicCategoryBySlug(),
        fetchDataComicCategoryByChange(slug: categories![0].slug),
      ]);
    }

    isLoading.value = false;

    update([
      "listNewestID",
      "sliderID",
      "IDListComplete",
      "IDListNowRelease",
      "ListByCategoryID_1",
      "ListByCategoryID_2",
      "ListNewUpdateID",
      "ReadContinue",
    ]);
  }

  Future<void> setCategoryCache() async {
    await ComicApi.setCategoryCache();
    categories = await ComicApi.getCategoryCache();
  }

  Future<void> fetchDataHomeApi() async {
    final result = await ComicApi.getHomeData();
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataSlider = apiResponse;
        listDataSlider.items = apiResponse.items.sublist(0, 6);
      }
    }
  }

  Future<void> fetchListNovel() async {
    Result result = await NovelData.getListNovel();
    if (result.status == Status.success) {
      listNovel = result.data;
    }
  }

  Future<void> fetchDataListComingSoon() async {
    final result = await ComicApi.getListComingSoon();
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataComingSoon = apiResponse;
      }
    }
  }

  Future<void> fetchDataListComplete() async {
    final result = await ComicApi.getListComplete(page: 2);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataComplete = apiResponse;
        listDataComplete.titlePage = TextFormat.capitalizeEachWord(
            listDataComplete.titlePage.replaceAll("Truyện tranh", ""));
      }
    }
  }

  Future<void> fetchDataListNowRelease() async {
    final result = await ComicApi.getListNowRelease(page: 3);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataNowRelease = apiResponse;
        listDataNowRelease.titlePage = TextFormat.capitalizeEachWord(
            listDataNowRelease.titlePage.replaceAll("Truyện tranh", ""));
      }
    }
  }

  Future<void> fetchDataListNewUpdate() async {
    final result = await ComicApi.getListNewUpdate(page: 1);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataNewUpdate = apiResponse;
      }
    }
  }

  Future<void> fetchDataComicCategoryBySlug() async {
    for (var i = 10; i <= 12; i++) {
      final result =
          await ComicApi.getListComicCategoryBySlug(slug: categories![i].slug);
      if (result.status == Status.success) {
        final apiResponse = result.data;
        if (apiResponse != null) {
          listDataComicCategoryBySlug.add(apiResponse);
        }
      }
    }
  }

  Future<void> fetchDataComicCategoryByChange({required String slug}) async {
    final result = await ComicApi.getListComicCategoryBySlug(slug: slug);
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        listDataChangeCategory = apiResponse;
      }
    }
    update(["ListCategory"]);
  }

  Future<void> toDetailListBySlug({required String slug}) async {
    Get.toNamed(Routes.category, arguments: {"slugQuery": slug});
  }

  String getSlugByTitlePage({required String title}) {
    ListCategoryModel? category = categories?.firstWhere(
      (category) => category.name == title,
    );
    if (category?.slug == null) {
      return "";
    }
    return category!.slug;
  }
}
