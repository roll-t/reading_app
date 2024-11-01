import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/data/database/comment_data.dart';
import 'package:reading_app/core/data/domain/auth_use_case.dart';
import 'package:reading_app/core/data/dto/request/commentRequest.dart';
import 'package:reading_app/core/data/dto/response/commentReponse.dart';

class CommentController extends GetxController {
  dynamic argumentNovelId = Get.arguments["novelId"];
  var isLoading = false.obs;
  var listComment = <CommentResponse>[].obs;
  var auth = Rxn<Map<String, dynamic>>();

  bool isManipulate = false;

  String? commentValue;
  final CommentData commentData = CommentData();

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
    if (argumentNovelId != null) {
      var response = await commentData.fetchAllComment(bookId: argumentNovelId);
      if (response.status == Status.success) {
        listComment.value = response.data ?? [];
      }
    }
  }

  Future<void> addComment(String content) async {
    if (argumentNovelId != null &&
        auth.value?["uid"] != null &&
        content.isNotEmpty) {
      var response = await commentData.addComment(
        request:
            CommentRequest(userId: auth.value!["uid"], content: content.trim()),
        bookId: argumentNovelId,
      );
      if (response.status == Status.success && response.data != null) {
        isManipulate = true;
        listComment.insert(0, response.data!);
      }
    }
  }

  Future<void> deleteComment(String commentId) async {
    var response = await commentData.deleteReadingComment(commentId: commentId);
    if (response.status == Status.success) {
      isManipulate = true;
      listComment.removeWhere((comment) => comment.commentId == commentId);
      Fluttertoast.showToast(msg: "Đã xóa");
    }
  }
}
