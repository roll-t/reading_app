import 'package:reading_app/core/services/entities/models/user_model.dart';
import 'package:reading_app/features/auth/domain/repositories/user_repository.dart';

class GetRememberedUserUsecase {
  final UserRepository _repository;

  GetRememberedUserUsecase(this._repository);

  Future<UserModel?> call() async {
    return await _repository.getRememberUser();
  }
}
