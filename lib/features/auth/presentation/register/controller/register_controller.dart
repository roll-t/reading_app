import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/user_request.dart';
import 'package:reading_app/core/services/api/data/sources/locals/user_service.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
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

  //
  UserService userData = Get.find();

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

    // Result emailExist =await UserData.emailExist(email: emailController.text.trim());

    // if (emailExist.data == true) {
    //   errorMessageEmail.value = AppErrors.emailExistError;
    //   return;
    // } else {
    //   errorMessageEmail.value = "";
    // }

    // Nếu có lỗi, không thực hiện đăng ký
    if (errorMessageName.value.isNotEmpty ||
        errorMessageEmail.value.isNotEmpty ||
        errorMessagePassword.value.isNotEmpty ||
        errorMessagePasswordConfirm.value.isNotEmpty) {
      return;
    }

    UserRequest userRequestModel = UserRequest(
        displayName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim());
        
    var userModel = await userData.signInAPI(userRequest: userRequestModel);

    print(userModel?.data);


    if (userModel?.data != null) {
      Get.back(result: userModel);
      SnackbarUtil.showSuccess(AppSuccess.registrationSuccess);
    }
  }
}
