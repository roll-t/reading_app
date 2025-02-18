import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/configs/strings/messages/app_errors.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/user_request.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/auth_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/user_service.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/remember_user_case.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/save_user_use_case.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';

class LogInController extends GetxController {

  final SaveUserUseCase _saveUserUseCase;

  final RememberUserCase _rememberUserCase;

  final AuthService _authService;

  LogInController(this._saveUserUseCase, this._rememberUserCase, this._userService,this._authService);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var isLoading = false.obs;


  var errorMessageEmail = ''.obs;

  var errorMessagePassword = ''.obs;

  var errorMessage = ''.obs;

  var isCheckRememberAccount = false.obs;

  UserModel? user;

  final UserService _userService;
  dynamic dataArgument;
  UserModel? userRemember;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Prefs prefs = Prefs();

  @override
  void onInit() async {
    super.onInit();
    prefs.logout();
    await _googleSignIn.signOut();
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
    }
  }

  Future<void> toSignUp() async {
    final result = await Get.toNamed(Routes.register);
    if (result != null && result is Result) {
      final UserModel? userModel = result.data as UserModel?;
      if (userModel != null) {
        emailController.text = userModel.email;
      }
    }
  }

  void toggleCheck() {
    isCheckRememberAccount.value = !isCheckRememberAccount.value;
  }

  Future<AuthenticationModel?> _initToken({required String email, required String password}) async {
    try {
      final Result<AuthenticationModel>? auth = await _authService.token(
        userModel: UserModel(
          email: email.trim(),
          password: password.trim(),
        ),
      );
      if (auth != null && auth.status == Status.success) {
        _saveUserUseCase.saveToken(auth.data!);
        var user = JwtDecoder.decode(auth.data?.token ?? "");
        _saveUserUseCase.saveUser(UserModel(
            email: user['sub'],
            photoURL: user["photoURL"] ?? "",
            displayName: user["displayName"]));
        return auth.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> handleLogin() async {
    Result emailExits =
await _userService.fetchEmailExist(email: emailController.text.trim());
    if (emailExits.data != true) {
      errorMessageEmail.value = AppErrors.emailUncreated;
      return;
    } else {
      errorMessageEmail.value = "";
    }

    if (passwordController.text.isEmpty) {
      errorMessagePassword.value = AppErrors.errorEmpty;
      return;
    } else {
      errorMessagePassword.value = "";
    }

    isLoading.value = true;
    final AuthenticationModel? auth = await _initToken(
        email: emailController.text, password: passwordController.text);
    if (isCheckRememberAccount.value) {
      _rememberUserCase.set(UserModel(email: emailController.text.trim()));
    }
    isLoading.value = false;
    if (auth != null && auth.authenticated) {
      Get.toNamed(Routes.main);
      SnackbarUtil.showSuccess(AppSuccess.loginSuccess);
    } else {
      SnackbarUtil.showSuccess(AppErrors.loginError);
    }
  }

  Future<void> handleSignInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        final userLogin = _createUserLoginMap(account);
        final userExists = await _userService.fetchUser(uid: account.id);
        isLoading.value = true;
        final result = await _handleUserSignIn(userExists, userLogin);
        if (result != null) {
          final auth = await _initToken(
            email: result.email,
            password: result.password ?? "0123456",
          );
          if (auth != null && auth.authenticated) {
            Get.offAllNamed(Routes.main);
            SnackbarUtil.showSuccess(AppSuccess.loginSuccess);
          } else {
            SnackbarUtil.showError(AppErrors.loginError);
          }
        }
      }
    } catch (error) {
      SnackbarUtil.showError(AppErrors.failLoginProcess);
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic> _createUserLoginMap(GoogleSignInAccount account) {
    UserRequest userRequestModel = UserRequest(
        uid: account.id,
        displayName: account.displayName,
        email: account.email,
        photoURL: account.photoUrl);
    return userRequestModel.toJson();
  }

  Future<UserModel?> _handleUserSignIn(
      Result? userExists, Map<String, dynamic> userLogin) async {
    if (userExists == null || userExists.status == Status.error) {
      UserRequest userRequestModel = UserRequest.fromJson(userLogin);
      final response =
          await _userService.signInAPI(userRequest: userRequestModel);
      return response?.data;
    } else {
      return userExists.data;
    }
  }
}
