import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/configs/strings/messages/app_errors.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/data/firebase/firebae_auth/firebase_auth.dart';
import 'package:reading_app/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:reading_app/core/data/firebase/model/result.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';
import 'package:reading_app/core/utils/validator.dart';
import 'package:reading_app/features/auth/user/domain/use_case/remember_user_case.dart';
import 'package:reading_app/features/auth/user/domain/use_case/save_user_use_case.dart';

class LogInController extends GetxController {
  final SaveUserUseCase _saveUserUseCase;
  final RememberUserCase _rememberUserCase;

  LogInController(this._saveUserUseCase, this._rememberUserCase);

  // Controllers for input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  // Error messages
  var errorMessageEmail = ''.obs;
  var errorMessagePassword = ''.obs;
  var errorMessage = ''.obs;

  var isCheckRememberAccount = false.obs;

  UserModel? user;
  dynamic dataArgument;
  UserModel? userRemember;

  @override
  void onInit() async {
    super.onInit();

    dataArgument = Get.arguments;

    userRemember = await _rememberUserCase.get();
    if (dataArgument is String) {
      emailController.text = dataArgument;
    } else if (dataArgument is UserModel) {
      user = dataArgument;
      emailController.text = user?.email ?? '';
    }

    if (userRemember != null) {
      emailController.text = userRemember!.email;
      passwordController.text = userRemember!.password;
    }
  }

  void toggleCheck() {
    isCheckRememberAccount.value = !isCheckRememberAccount.value;
  }

  Future<void> handleLogin() async {
    errorMessageEmail.value = '';
    errorMessagePassword.value = '';
    
    final emailError = Validators.checkErrorsLength(value: emailController.text, minLenth: 8, maxLength: 50) +
        Validators.checkErrorEmail(value: emailController.text);
    final passwordError = Validators.checkErrorsLength(value: passwordController.text, minLenth: 6, maxLength: 20);
    
    if (emailError.isNotEmpty) {
      errorMessageEmail.value = emailError;
    }
    if (passwordError.isNotEmpty) {
      errorMessagePassword.value = passwordError;
    }

    if (errorMessageEmail.value.isNotEmpty || errorMessagePassword.value.isNotEmpty) {
      return;
    }

    isLoading.value = true;

    Result result = await FirebaseAuthentication.logIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    
    isLoading.value = false;

    if (result.status == Status.success) {
      UserModel userLogin = UserModel(
          displayName: result.data.displayName,
          email: result.data.email,
          password: passwordController.text,
          creationTime: "");
      await _saveUserUseCase.saveUser(userLogin);
      await rememberUser(rememberCheck: isCheckRememberAccount.value);
      SnackbarUtil.showSuccess(AppSuccess.loginSuccess);
      Get.offAndToNamed(Routes.main);
    } else {
      SnackbarUtil.showError(AppErrors.loginFail);
    }
  }

  Future<void> logInWithGoogle() async {
    errorMessage.value = ''; // Reset error message

    Result<UserModel> result = await FirebaseAuthentication.signInWithGoogle();

    if (result.status == Status.success) {
      isLoading.value = true;
      UserModel user = result.data!;
      await FirestoreUser.createUser(user);
      await _saveUserUseCase.saveUser(user);
      isLoading.value = false;
      SnackbarUtil.showSuccess(AppSuccess.loginSuccess);
      Get.offAndToNamed(Routes.main);
    } else {
      errorMessage.value = 'An unknown error occurred';
      SnackbarUtil.showError(AppErrors.loginFail);
    }
  }

  Future<void> rememberUser({bool rememberCheck = false}) async {
    if (rememberCheck) {
      UserModel userRemember = UserModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          creationTime: DateTime.now().toString());
      await _rememberUserCase.set(userRemember);
    }
  }
}
