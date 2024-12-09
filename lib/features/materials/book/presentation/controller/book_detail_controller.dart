import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/remote/comic_api.dart';
import 'package:reading_app/core/service/service/model/authentication_model.dart';
import 'package:reading_app/core/service/service/model/comic_model.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';

class BookDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabController;
  var tabIndex = 0.obs;
  var opacity = 0.0.obs;
  var isLoading = false.obs;

  var isAuth = false.obs;

  ComicModel? comicModel;
  String title = "";
  String thumb = "";
  String description = "";

  List<dynamic> chapters = [];
  List<dynamic> category = [];


  List<String> listIntroduceSlide = [];

  List<dynamic> listComicNewest = [];

  String titleListComplete ="";

  String domainImage ="";

  dynamic slugArgument;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      if (Get.arguments["slug"] != null) {
        slugArgument = Get.arguments["slug"];
      }
    }

    await initial();
    isLoading.value = false;
    scrollController.addListener(_scrollListening);
  }

  initial() async {
    tabController = TabController(length: 2, vsync: this);
    await fetchDataAPI();
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }


  Future<void> fetchDataAPI() async {
    try {
      final result = await ComicApi.getBookDetailDataAPI(slug: slugArgument);
      if (result.status == Status.success) {
        comicModel = result.data;
        title = comicModel!.title;
        thumb = comicModel!.thumb;
        description = comicModel!.description;
        chapters = comicModel!.chapters ?? [];
        category = comicModel?.category ?? [];
        isAuth.value = true;
      } else {
        switch (result.error) {
          case ApiError.badRequest:
            SnackbarUtil.showError("Lỗi không tìm thấy dữ liệu");
            break;
          case ApiError.unauthorized:
            isAuth.value = false;
            break;
          case ApiError.notFound:
            SnackbarUtil.showError("Không tìm thấy dữ liệu");
            break;
          case ApiError.serverError:
            SnackbarUtil.showError("Lỗi kết nối máy chủ");
            break;
          case ApiError.unknown:
            SnackbarUtil.showError("Lỗi mạng");
            break;
          case null:
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleLogin() async {
    isLoading.value = true;
    var result = await Get.toNamed(Routes.login);
    if (result != null && result is AuthenticationModel) {
      if (result.authenticated) {
        isAuth.value = result.authenticated;
        await fetchDataAPI();
        isLoading.value = false;
      }
    }
  }

  void _scrollListening() {
    if (!scrollController.hasClients) return;
    double offset = scrollController.offset;
    double threshold = 350.0 / 2;
    if (offset >= threshold) {
      opacity.value = 1.0;
    } else if (offset < threshold && offset > 0) {
      opacity.value = offset / threshold;
    } else {
      opacity.value = 0.0;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListening);
    scrollController.dispose();
    super.onClose();
  }

}
