import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/service/domain/usecase/users/remember_user_usecase.dart';
import 'package:reading_app/features/auth/login/domain/repositories/login_repository.dart';

class SigninUseCase {
  final LoginRepository _repository;
  final RememberUserUsecase _rememberUserUsecase;
  SigninUseCase(this._repository, this._rememberUserUsecase);
  Future<UserModel?> call({
    required String email,
    required String password,
    required bool rememberUserLastSignin,
  }) async {
    try {
      var result = await _repository.signin(email, password);
      print(result);
      if (rememberUserLastSignin) {
        _rememberUserUsecase(result ?? UserModel(email: "None"));
      }
      return result;
    } catch (e) {
      print("Error in HandleSigninUseCase: $e");
      return null;
    }
  }
}
