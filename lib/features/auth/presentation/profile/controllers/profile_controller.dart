import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/entities/models/user_model.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/auth/domain/usecase/auth/auth_use_case.dart';
import 'package:reading_app/features/auth/domain/usecase/user/get_user_use_case.dart';

class ProfileController extends GetxController {
  final prefs = Prefs();

  final GetuserUseCase _getuserUseCase;

  ProfileController(this._getuserUseCase);

  var isLogin = false.obs;
  var isLoading = false.obs;

  AuthUseCase? authUseCase;

  String jwtToken = "";

  var userModel = UserModel().obs;

  @override
  onInit() async {
    super.onInit();
    await _checkLogin();
    await _initializeHeaders();
  }

  // Initializes headers and loads user data based on token and cache
  Future<void> _initializeHeaders() async {
    jwtToken = await AuthUseCase.getAuthToken();
    if (jwtToken.isNotEmpty) {
      // Try to load user data from cache (in case of an existing session)
      UserModel? userCache = await _getuserUseCase();

      userModel.value.uid = userCache?.uid ?? "";
      userModel.value.email = userCache?.email ?? "";
      userModel.value.displayName = userCache?.displayName ?? "";
      userModel.value.photoURL = userCache?.photoURL ?? "";
    }
  }

  // Checks if the user is logged in
  Future<void> _checkLogin() async {
    isLoading.value = true;
    isLogin.value = await AuthUseCase.isLogin();
    isLoading.value = false;
  }

  // Reloads user data, refreshing from cache or token
  Future<void> reloadData() async {
    isLoading.value = true;
    await _initializeHeaders();
    update(["bodyId"]);
    isLoading.value = false;
  }

  // Logs out the user and clears session
  Future<void> logout() async {
    isLoading.value = true;
    await prefs.logout();
    Get.offAllNamed(Routes.login);
    isLoading.value = false;
  }

  // Handles login action
  Future<void> handleLogin() async {
    isLoading.value = true;
    var result = await Get.toNamed(Routes.login);
    if (result != null &&
        result is AuthenticationModel &&
        result.authenticated) {
      await _initializeHeaders();
      isLogin.value = result.authenticated;
    }
    isLoading.value = false;
  }
}
