import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';
import 'package:reading_app/features/auth/domain/usecase/user/get_remembered_user_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/login/google_signin_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/login/signin_usecase.dart';

class LoginController extends GetxController {
  final SigninUseCase _signinUseCase;
  final GetRememberedUserUsecase _getRememberedUserUsecase;

  final GoogleSignInUseCase _googleSignInUseCase;

  LoginController(
    this._signinUseCase,
    this._googleSignInUseCase,
    this._getRememberedUserUsecase,
  );

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var isLoading = false.obs;

  var isWaitProcess = false.obs;

  var errorMessageEmail = ''.obs;

  var errorMessagePassword = ''.obs;

  var errorMessage = ''.obs;

  var isCheckRememberLastLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    // check if user has remembered last login
    _getRememberedUserUsecase().then((user) {
      if (user != null) {
        emailController.text = user.email;
        isCheckRememberLastLogin.value = true;
      }
    });
  }

  // handle signin with email and password
  Future<void> handleLogin() async {
    isWaitProcess.value = true;
    final result = await _signinUseCase(
      email: emailController.text,
      password: passwordController.text,
      rememberUserLastSignin: isCheckRememberLastLogin.value,
    );
    if (result == null) {
      SnackbarUtil.showError("Lỗi đăng nhập");
    } else {
      Get.offAllNamed(Routes.main);
    }
    isWaitProcess.value = false;
  }

  // handle event login with google
  Future<void> handleLoginWithGoogle() async {
    isWaitProcess.value = true;
    final result = await _googleSignInUseCase();
    if (result == null) {
      SnackbarUtil.showError("Lỗi đăng nhập");
    } else {
      Get.offAllNamed(Routes.main);
    }
    isWaitProcess.value = false;
  }
}
