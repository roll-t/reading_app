import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/data/model/authentication_model.dart';
import 'package:reading_app/core/services/data/model/user_model.dart';
import 'package:reading_app/core/services/domain/auth_use_case.dart';
import 'package:reading_app/core/services/prefs/prefs.dart';

class ProfileController extends GetxController {
  final prefs = Prefs();

  var isLogin = false.obs;

  var isLoading = false.obs;

  AuthUseCase? authUseCase;

  String jwtToken = "";

  var userModel =
      UserModel(email: " ", photoURL: "", displayName: "no name").obs;

  @override
  onInit() async {
    super.onInit();
    await _checkLogin();
    await _initializeHeaders();
  }

  Future<void> _initializeHeaders() async {
    jwtToken = await AuthUseCase.getAuthToken();
    if (jwtToken != "") {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
      userModel.value.email = decodedToken["sub"];
      userModel.value.displayName = decodedToken["displayName"];
      userModel.value.photoURL = decodedToken["photoURL"];
    }
  }

  Future<void> _checkLogin() async {
    isLoading.value = true;
    isLogin.value = await AuthUseCase.isLogin();
    isLoading.value = false;
  }

  Future<void> logout() async {
    isLoading.value = true;
    await prefs.logout();
    isLogin.value = await AuthUseCase.isLogin();
    isLoading.value = false;
  }

  Future<void> handleLogin() async {
    isLoading.value = true;
    var result = await Get.toNamed(Routes.login);
    if (result != null) {
      // jwtToken = result["token"];
      await _initializeHeaders();
    }
    isLoading.value = false;
    if (result != null && result is AuthenticationModel) {
      if (result.authenticated) {
        isLogin.value = result.authenticated;
      }
    }
  }
}
