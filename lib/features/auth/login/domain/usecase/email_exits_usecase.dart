import 'package:reading_app/features/auth/login/domain/repositories/login_repository.dart';

class EmailExitsUsecase {
  final LoginRepository _repository;
  EmailExitsUsecase(this._repository);

  Future<bool> call(String email) async {
    try {
      return await _repository.emailExits(email);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
