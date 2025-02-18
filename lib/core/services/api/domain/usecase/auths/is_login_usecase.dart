import 'package:reading_app/core/services/api/domain/repositories/auth_repository.dart';

class IsLoginUseCase {
  final AuthRepository _repository;
  IsLoginUseCase(this._repository);

  Future<bool> call() async {
    try {
      return await _repository.isLogin();
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }
}
