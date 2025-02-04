import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/reading_book_case_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/auth_use_case.dart';
import 'package:reading_app/features/materials/book_details/layout_book_detail/data/entities/arguments/layout_book_detail_argument.dart';

class LayoutBookDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  final filteredChapters = <ChapterNovelModel>[].obs;
  final filteredChapterComic = <dynamic>[].obs;
  final tabIndex = 0.obs;
  final opacity = 0.0.obs;
  final isLoading = false.obs;
  final isAuth = false.obs;
  final scrollController = ScrollController();

  late TabController tabController;
  String searchQuery = '';

  ReadingBookCaseResponse? bookCaseModel;
  ReadingComicBookCaseModel? readingComicBookCaseModel;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    scrollController.addListener(_scrollListening);
    _initialize();
    isLoading.value = false;
  }

  Future<void> _initialize() async {
    tabController = TabController(length: 2, vsync: this);

    final args = LayoutBookDetailArgument.fromMap(Get.arguments);
    bookCaseModel = args.readContinue;
    readingComicBookCaseModel = args.readingComicBookCase;

    isAuth.value = await AuthUseCase.isLogin();
    tabController.addListener(() => tabIndex.value = tabController.index);
  }

  CategoryModel convertToCategoryModel(CategoryResponse response) {
    return CategoryModel(
      name: response.name,
      slug: response.slug,
      id: '',
    );
  }

  Future<void> handleLogin() async {
    isLoading.value = true;
    final result = await Get.toNamed(Routes.login);
    if (result is AuthenticationModel && result.authenticated) {
      isAuth.value = result.authenticated;
    }
    isLoading.value = false;
  }

  void _scrollListening() {
    if (!scrollController.hasClients) return;

    final offset = scrollController.offset;
    const threshold = 175.0;

    opacity.value =
        offset >= threshold ? 1.0 : (offset / threshold).clamp(0.0, 1.0);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListening);
    scrollController.dispose();
    super.onClose();
  }

  List<ChapterNovelModel> filterChapters(List<ChapterNovelModel> chapters) {
    if (searchQuery.isEmpty) return chapters;
    final query = searchQuery.toLowerCase();
    return chapters.where((chapter) {
      return chapter.chapterTitle.toLowerCase().contains(query) ||
          chapter.chapterName.toLowerCase().contains(query);
    }).toList();
  }
}
