import 'dart:async';

import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/database/auth_service.dart';
import 'package:reading_app/core/service/api/dto/request/introspect_request.dart';
import 'package:reading_app/core/service/prefs/prefs.dart';
import 'package:reading_app/core/storage/use_case/auth_use_case.dart';

class SplashController extends GetxController {
  final AuthData authApi = AuthData();
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
      if (token.isNotEmpty) {
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
        Get.offAndToNamed(Routes.main);
      } else {
        Get.offNamed(Routes.login);
      }
    }
  }
}
