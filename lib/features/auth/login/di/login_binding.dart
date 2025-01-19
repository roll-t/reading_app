import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reading_app/core/service/api/locals/auth_service.dart';
import 'package:reading_app/core/service/api/locals/user_service.dart';
import 'package:reading_app/core/service/data/repositories/auth_repository_impl.dart';
import 'package:reading_app/core/service/data/repositories/user_repository_impl.dart';
import 'package:reading_app/core/service/domain/repositories/auth_repository.dart';
import 'package:reading_app/core/service/domain/repositories/user_repository.dart';
import 'package:reading_app/core/service/domain/usecase/auths/set_token_usecase.dart';
import 'package:reading_app/core/service/domain/usecase/users/remember_user_usecase.dart';
import 'package:reading_app/core/service/domain/usecase/users/set_user_usecase.dart';
import 'package:reading_app/core/service/storage/prefs/prefs.dart';
import 'package:reading_app/features/auth/login/data/repositories/login_repository_impl.dart';
import 'package:reading_app/features/auth/login/domain/repositories/login_repository.dart';
import 'package:reading_app/features/auth/login/domain/usecase/google_signin_usecase.dart';
import 'package:reading_app/features/auth/login/domain/usecase/signin_usecase.dart';
import 'package:reading_app/features/auth/login/presentation/controller/login_controller.dart';

class LoginBindding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut(() => AuthService(Get.find(), Get.find()));
    Get.lazyPut(() => UserService(Get.find(), Get.find()));
    Get.lazyPut<UserRepository>(
        () => UserRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut(() => GoogleSignIn());
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut(() => RememberUserUsecase(Get.find()));
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => SigninUseCase(Get.find(), Get.find()));
    Get.lazyPut(() => SetTokenUsecase(Get.find()));
    Get.lazyPut(() => SetUserUsecase(Get.find()));
    Get.lazyPut(() => GoogleSignInUseCase(Get.find()));

    Get.lazyPut(() => LoginController(Get.find(), Get.find()));
  }
}
