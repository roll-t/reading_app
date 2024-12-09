import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/api/database/comment_comic_service.dart';
import 'package:reading_app/core/service/api/database/comment_service.dart';
import 'package:reading_app/core/service/api/dto/request/commentRequest.dart';
import 'package:reading_app/core/service/api/dto/request/comment_comic_request.dart';
import 'package:reading_app/core/service/api/dto/response/commentReponse.dart';
import 'package:reading_app/core/storage/use_case/auth_use_case.dart';

class CommentController extends GetxController {
  dynamic argumentNovelId = Get.arguments["novelId"];

  dynamic argumentComicId = Get.arguments["comicId"];

  var isLoading = false.obs;

  var isLoadingProcess = false.obs;

  var listComment = <CommentResponse>[].obs;

  var auth = Rxn<Map<String, dynamic>>();

  bool isManipulate = false;

  String? commentValue;

  final CommentData commentData = CommentData();

  final CommentComicData commentComicData = CommentComicData();

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    _initialize();
  }

  Future<void> _initialize() async {
    await _initializeAuth();
    await fetchComments();
    isLoading.value = false;
  }

  Future<void> _initializeAuth() async {
    String? token = await AuthUseCase.getAuthToken();
    auth.value = JwtDecoder.decode(token);
  }

  Future<void> fetchComments() async {
    var response = argumentNovelId != null
        ? await commentData.fetchAllComment(bookId: argumentNovelId)
        : await commentComicData.fetchAllComment(bookId: argumentComicId);
    if (response.status == Status.success) {
      listComment.value = response.data ?? [];
    }
  }

  Future<void> addComment(String content) async {
    isLoadingProcess.value = true;
    if (!(auth.value?["uid"] != null && content.isNotEmpty)) return;
    if (argumentNovelId != null) {
      var response = await commentData.addComment(
        request:
            CommentRequest(userId: auth.value!["uid"], content: content.trim()),
        bookId: argumentNovelId,
      );
      if (response.status == Status.success && response.data != null) {
        isManipulate = true;
        listComment.insert(0, response.data!);
        Fluttertoast.showToast(msg: "Đã bình luận");
      }
    } else if (argumentComicId != null) {
      var response = await commentComicData.addComment(
        request: CommentComicRequest(
            userId: auth.value!["uid"],
            content: content.trim(),
            comicId: argumentComicId),
      );
      if (response.status == Status.success && response.data != null) {
        isManipulate = true;
        listComment.insert(0, response.data!);
        Fluttertoast.showToast(msg: "Đã bình luận");
      }
    }
    isLoadingProcess.value = false;
  }

  Future<void> deleteComment(String commentId) async {
    isLoadingProcess.value = true;
    var response = argumentNovelId != null
        ? await commentData.deleteReadingComment(commentId: commentId)
        : await commentComicData.deleteReadingComment(commentId: commentId);

    if (response.status == Status.success) {
      isManipulate = true;
      listComment.removeWhere((comment) => comment.commentId == commentId);
      Fluttertoast.showToast(msg: "Đã xóa");
    }
    isLoadingProcess.value = false;
  }
}
