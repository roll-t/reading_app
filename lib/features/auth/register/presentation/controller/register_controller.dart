import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/messages/app_errors.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/services/api/user_api.dart';
import 'package:reading_app/core/services/data/model/result.dart';
import 'package:reading_app/core/services/data/model/user_request_model.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';
import 'package:reading_app/core/utils/validator.dart';

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

  // Phương thức đăng ký
  Future<void> signUp() async {
    // Reset thông báo lỗi
    errorMessageName.value = '';
    errorMessageEmail.value = '';
    errorMessagePassword.value = '';
    errorMessagePasswordConfirm.value = '';

    // check user name
    if (Validators.checkErrorsLength(
            value: nameController.text, minLenth: 4, maxLength: 50)
        .isNotEmpty) {
      errorMessageName.value = Validators.checkErrorsLength(
          value: nameController.text, minLenth: 4, maxLength: 50);
    }

    // check user name
    if (Validators.checkErrorsLength(
            value: emailController.text, minLenth: 8, maxLength: 50)
        .isNotEmpty) {
      errorMessageEmail.value = Validators.checkErrorsLength(
          value: emailController.text, minLenth: 8, maxLength: 20);
    }

    // checkpassword
    if (Validators.checkErrorsLength(
            value: passwordController.text, minLenth: 6, maxLength: 11)
        .isNotEmpty) {
      errorMessagePassword.value = Validators.checkErrorsLength(
          value: passwordController.text, minLenth: 6, maxLength: 11);
    }

    // check email format
    if (Validators.checkErrorEmail(value: emailController.text).isNotEmpty) {
      errorMessageEmail.value =
          Validators.checkErrorEmail(value: emailController.text);
    }

    //check match
    if (errorMessagePassword.value.isEmpty) {
      if (Validators.checkMatch(
              value_1: passwordController.text,
              value_2: passwordConfirmController.text)
          .isNotEmpty) {
        errorMessagePasswordConfirm.value = Validators.checkMatch(
            value_1: passwordController.text,
            value_2: passwordConfirmController.text);
      }
    }

    Result emailExist = await UserApi.emailExist(email: emailController.text.trim());

    if (emailExist.data == true) {
      errorMessageEmail.value = AppErrors.emailExistError;
      return;
    } else {
      errorMessageEmail.value = "";
    }

    // Nếu có lỗi, không thực hiện đăng ký
    if (errorMessageName.value.isNotEmpty ||
        errorMessageEmail.value.isNotEmpty ||
        errorMessagePassword.value.isNotEmpty ||
        errorMessagePasswordConfirm.value.isNotEmpty) {
      return;
    }

    UserRequestModel userRequestModel = UserRequestModel(
        displayName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    String dataJson = jsonEncode(userRequestModel.toJson());

    Result? userModel = await UserApi.signIn(userRequest: dataJson);

    if(userModel!=null){
      Get.back(result:userModel);
      SnackbarUtil.showSuccess(AppSuccess.registrationSuccess);
    }
  }
}
