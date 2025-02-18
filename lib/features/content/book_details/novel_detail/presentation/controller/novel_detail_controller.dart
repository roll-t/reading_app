import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/novel_model.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/auth_use_case.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/usecase/fetch_all_category_usecase.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/usecase/fetch_all_comment_of_novel_usecase.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/usecase/fetch_chapters_of_novel_usecase.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/usecase/fetch_novel_by_id_usecase.dart';

class NovelDetailController extends GetxController {
  final FetchAllCategoryUsecase _fetchAllCategoryUsecase;
  final FetchAllCommentOfNovelUsecase _fetchAllCommentOfNovelUsecase;
  final FetchChaptersOfNovelUsecase _fetchChaptersOfNovelUsecase;
  final FetchNovelByIdUsecase _fetchNovelByIdUsecase;

  NovelDetailController(
    this._fetchAllCategoryUsecase,
    this._fetchAllCommentOfNovelUsecase,
    this._fetchChaptersOfNovelUsecase,
    this._fetchNovelByIdUsecase,
  );

  final isLoading = false.obs;
  final isLoadingComment = false.obs;

  // Define variables
  NovelModel novelModel = NovelModel(name: "", thumbUrl: "");

  String slugArgumentNovelId = "";

  String authId = "";

  final listChapter = <ChapterNovelModel>[].obs;
  final categories = <CategoryResponse>[].obs;
  final listComment = <CommentResponse>[].obs;

  @override
  void onInit() async {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      slugArgumentNovelId = arguments["novelId"] ?? '';
    }
    if (slugArgumentNovelId.isNotEmpty) {
      final token = await AuthUseCase.getAuthToken();
      authId = JwtDecoder.decode(token)["uid"];
      isLoading.value = true;
      await fetchNovel();
      fetchCategories();
      fetchListComment(bookId: slugArgumentNovelId);
      isLoading.value = false;
    }
  }

  Future<void> fetchNovel() async {
    final result = await _fetchNovelByIdUsecase(novelId: slugArgumentNovelId);
    if (result != null) {
      novelModel = result;
      listChapter.value =
          await _fetchChaptersOfNovelUsecase(slug: novelModel.slug ?? "") ?? [];
    }
  }

  Future<void> fetchCategories() async {
    final allCategories = await _fetchAllCategoryUsecase() ?? [];
    categories.value = allCategories
        .where((category) =>
            novelModel.categorySlug?.contains(category.slug) ?? false)
        .toList();
  }

  Future<void> fetchListComment({required String bookId}) async {
    listComment.value =
        await _fetchAllCommentOfNovelUsecase(novelId: bookId) ?? [];
  }
}
