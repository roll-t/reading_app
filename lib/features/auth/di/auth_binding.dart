import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';
import 'package:reading_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:reading_app/features/auth/data/repositories/login_repository_impl.dart';
import 'package:reading_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:reading_app/features/auth/data/sources/auth_service.dart';
import 'package:reading_app/features/auth/data/sources/user_service.dart';
import 'package:reading_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:reading_app/features/auth/domain/repositories/login_repository.dart';
import 'package:reading_app/features/auth/domain/repositories/user_repository.dart';
import 'package:reading_app/features/auth/domain/usecase/user/set_remember_user_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/user/get_remembered_user_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/login/google_signin_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/login/signin_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/user/set_token_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/user/set_user_usecase.dart';
import 'package:reading_app/features/auth/presentation/login/controller/login_controller.dart';
import 'package:reading_app/features/auth/presentation/register/controller/register_controller.dart';

// create dependence for auth feature
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => Prefs(),
      fenix: true,
    );

    Get.lazyPut(
      () => AuthService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => UserService(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );

    // ===> login dependence
    Get.lazyPut(
      () => GoogleSignIn(),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SetRememberUserUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SigninUseCase(
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SetTokenUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => SetUserUsecase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => GoogleSignInUseCase(
        Get.find(),
      ),
    );
    Get.lazyPut(
      () => GetRememberedUserUsecase(
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => LoginController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );

    //===> Register dependence
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(
      () => RegisterController(
        Get.find(),
      ),
    );
  }
}
