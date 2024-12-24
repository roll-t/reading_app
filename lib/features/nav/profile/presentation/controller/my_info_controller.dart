import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/data/api/database/user_service.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/service/utils/images_service.dart';
import 'package:reading_app/core/storage/use_case/get_user_use_case.dart';
import 'package:reading_app/core/storage/use_case/save_user_use_case.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';

class MyInfoController extends GetxController {
  final ImagesService imagesService = ImagesService();

  bool isUpdated = false;

  UserModel authArgument = Get.arguments;

  Rx<UserModel> userModel = UserModel(email: "").obs;

  final SaveUserUseCase _saveUserUseCase;
  final GetuserUseCase _getuserUseCase;
  final textController = TextEditingController();
  RxBool errorDisplayName = false.obs;
  RxString displayName = "".obs;
  String photoUrl = "";
  var isLoading = false.obs;

  MyInfoController(this._saveUserUseCase, this._getuserUseCase);

  UserData userData = UserData();

  @override
  void onInit() async {
    super.onInit();
    await _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    userModel.value = await _getuserUseCase.getUser() ?? UserModel(email: "");
    userModel.value.uid = authArgument.uid;
    displayName.value = userModel.value.displayName ?? "";
    textController.text = displayName.value;
    textController.addListener(() {
      displayName.value = textController.text;
    });
    photoUrl = userModel.value.photoURL ?? "";
    update(["bodyId"]);
  }

  Future<void> updateDisplayName(String? displayName) async {
    final regex = RegExp(r'^[a-zA-Z0-9À-ỹ ]*$');

    if (displayName == userModel.value.displayName) {
      SnackbarUtil.showInfo("Không có gì thay đổi");
      return;
    }

    if (displayName?.trim().isEmpty ?? true) {
      SnackbarUtil.showInfo("Không được bỏ trống");
      return;
    }

    if (!regex.hasMatch(displayName ?? "")) {
      SnackbarUtil.showInfo("Không được chứa ký tự đặc biệt");
      return;
    }

    await _updateUserInfo(displayName: displayName);
  }

  Future<void> _updateUserInfo({String? displayName, String? imageUrl}) async {
    isLoading.value = true;

    final Map<String, dynamic> request = {};
    if (displayName != null && displayName != "") {
      request["displayName"] = displayName;
    }
    if (imageUrl != null) request["photoURL"] = imageUrl;

    final response = await userData.updateUser(
        uid: userModel.value.uid ?? "", request: request);

    isLoading.value = false;
    if (response.status == Status.success) {
      _onUpdateSuccess(displayName, imageUrl);
    } else {
      SnackbarUtil.showError("Lỗi không thể cập nhật");
    }
  }

  void _onUpdateSuccess(String? displayName, String? imageUrl) {
    if (displayName != null) userModel.value.displayName = displayName;
    if (imageUrl != null) userModel.value.photoURL = imageUrl;

    _saveUserUseCase.saveUser(UserModel(
        email: userModel.value.email,
        photoURL: imageUrl ?? userModel.value.photoURL,
        displayName: displayName ?? userModel.value.displayName));
    isUpdated = true;
    _initializeUserData();
    SnackbarUtil.showSuccess("Thay đổi thành công");
  }

  void onDisplayNameChanged(String value) {
    if (value.length > 20) {
      errorDisplayName.value = true;
      textController.text = value.substring(0, 20);
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
    } else {
      errorDisplayName.value = false;
      displayName.value = value;
    }
  }

  Future<void> uploadImage(String imagePath) async {
    if (imagePath.isEmpty) {
      SnackbarUtil.showError("Lỗi: Không có đường dẫn ảnh");
      return;
    }
    isLoading.value = true;
    final file = File(imagePath);
    final imageBytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

    if (image == null) {
      SnackbarUtil.showError("Lỗi: Không thể giải mã ảnh");
      isLoading.value = false;
      return;
    }

    img.Image resizedImage = img.copyResize(image, width: 300);

    final resizedImageBytes =
        Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

    final tempFile = File('${file.parent.path}/temp_resized_image.jpg');
    await tempFile.writeAsBytes(resizedImageBytes);

    if (await tempFile.length() > 50 * 1024) {
      final furtherResizedImageBytes =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 60));
      await tempFile.writeAsBytes(furtherResizedImageBytes);
    }

    if (photoUrl.isNotEmpty) {
      final oldImagePublicId = extractPublicIdFromUrl(photoUrl);
      if (oldImagePublicId.isNotEmpty) {
        try {
          await _deleteOldImage("book_cover/$oldImagePublicId");
        } catch (error) {
          SnackbarUtil.showError("Lỗi khi xóa ảnh cũ: $error");
          isLoading.value = false;
          return;
        }
      } else {
        print("No old image ID found to delete");
      }
    }

    final result = await _uploadImageAndGetUrl(tempFile.path);
    if (result != null) {
      userModel.update((val) {
        val?.photoURL = result;
      });
      await _updateUserInfo(imageUrl: result);
    }

    isLoading.value = false;
  }

  String extractPublicIdFromUrl(String url) {
    final segments = Uri.parse(url).pathSegments;
    if (segments.isNotEmpty) {
      final publicIdWithExtension = segments.last;
      final publicId = publicIdWithExtension.split('.').first;
      return publicId;
    }
    return '';
  }

  Future<void> _deleteOldImage(String imagePublicId) async {
    if (imagePublicId.isEmpty) {
      throw Exception("Không tìm thấy ID ảnh để xóa");
    }

    final Map<String, dynamic> payload = {
      'imageId': imagePublicId,
    };

    try {
      final result = await ImagesService.handleDelete(payload);
      print("Image deleted successfully: $result");
    } catch (error) {
      throw Exception("Lỗi khi xóa ảnh cũ: $error");
    }
  }

  Future<String?> _uploadImageAndGetUrl(String imagePath) async {
    final file = File(imagePath);
    final result = await ImagesService.handleUpload(file);
    if (result.containsKey('error')) {
      SnackbarUtil.showError("Lỗi: Không thể tải ảnh lên");
      return null;
    }
    return result["result"]['url'];
  }
}
