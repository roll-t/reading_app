import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/services/entities/dto/request/user_request.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';
import 'package:reading_app/core/utils/validator.dart';
import 'package:reading_app/features/auth/data/sources/user_service.dart';

class RegisterController extends GetxController {
  final Prefs prefs;
  RegisterController(this.prefs);

  // Controllers cho các trường nhập liệu
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  // Trạng thái loading
  var isLoading = false.obs;

  // Các thông báo lỗi
  var errorMessageName = ''.obs;
  var errorMessageEmail = ''.obs;
  var errorMessagePassword = ''.obs;
  var errorMessagePasswordConfirm = ''.obs;

  UserService userData = Get.find();

  void _resetErrors() {
    errorMessageName.value = '';
    errorMessageEmail.value = '';
    errorMessagePassword.value = '';
    errorMessagePasswordConfirm.value = '';
  }

  bool _validateInputs() {
    _resetErrors();

    errorMessageName.value = Validators.checkErrorsLength(
        value: nameController.text, minLenth: 4, maxLength: 50);

    errorMessageEmail.value = Validators.checkErrorsLength(
        value: emailController.text, minLenth: 8, maxLength: 50);

    if (errorMessageEmail.value.isEmpty) {
      errorMessageEmail.value =
          Validators.checkErrorEmail(value: emailController.text);
    }

    errorMessagePassword.value = Validators.checkErrorsLength(
        value: passwordController.text, minLenth: 6, maxLength: 11);

    if (errorMessagePassword.value.isEmpty) {
      errorMessagePasswordConfirm.value = Validators.checkMatch(
          value_1: passwordController.text,
          value_2: passwordConfirmController.text);
    }

    return errorMessageName.value.isEmpty &&
        errorMessageEmail.value.isEmpty &&
        errorMessagePassword.value.isEmpty &&
        errorMessagePasswordConfirm.value.isEmpty;
  }

  Future<void> signUp() async {
    if (!_validateInputs()) return;

    isLoading.value = true;
    
    try {
      UserRequest userRequestModel = UserRequest(
        displayName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      var userModel = await userData.signInAPI(userRequest: userRequestModel);
      if (userModel?.data == null) {
        errorMessageEmail("Email đã tồn tại");
        return;
      }
      if (userModel?.data != null) {
        Get.back(result: userModel);
        SnackbarUtil.showSuccess(AppSuccess.registrationSuccess);
      }
    } catch (e) {
      SnackbarUtil.showError("Đăng ký thất bại: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
