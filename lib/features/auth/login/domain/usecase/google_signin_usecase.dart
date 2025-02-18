import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/features/auth/login/domain/repositories/login_repository.dart';

class GoogleSignInUseCase {
  final LoginRepository _repository;
  GoogleSignInUseCase(this._repository);

  Future<UserModel?> call() async {
    try {
      return await _repository.googleSignIn();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
