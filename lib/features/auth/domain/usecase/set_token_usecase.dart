import 'package:reading_app/features/auth/domain/repositories/auth_repository.dart';

class SetTokenUsecase {
  final AuthRepository _repository;
  SetTokenUsecase(this._repository);

  Future<void> call(String token) async {
    _repository.setAuthToken(token);
  }
}
