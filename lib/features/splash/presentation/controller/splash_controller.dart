import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/auth_api.dart';
import 'package:reading_app/core/database/domain/auth_use_case.dart';
import 'package:reading_app/core/database/dto/request/introspect_request.dart';
import 'package:reading_app/core/database/prefs/prefs.dart';
import 'package:reading_app/core/routes/routes.dart';

class SplashController extends GetxController {
  final AuthApi authApi = AuthApi();
  final Prefs prefs = Prefs();

  var isAuth = false;

  @override
  void onInit() {
    super.onInit();
    initialValue();
  }

  Future<void> initialValue() async {
    try {
      var token = await AuthUseCase.getAuthToken();
      if (token != null && token.isNotEmpty) {
        var result =
            await authApi.introspect(request: IntrospectRequest(token: token));
        if (result.status == Status.success) {
          isAuth = result.data?.valid ?? false;
        }
      }
    } catch (e) {
      print('Error during authentication: $e');
    } finally {
      if (isAuth) {
        Get.toNamed(Routes.main);
      } else {
        Get.offNamed(Routes.login);
      }
    }
  }
}
