import 'package:reading_app/core/services/entities/models/user_model.dart';
import 'package:reading_app/features/auth/domain/repositories/user_repository.dart';

/// UseCase: Remember user
class SetRememberUserUsecase {
  final UserRepository _repository;

  SetRememberUserUsecase(this._repository);

  Future<void> call(UserModel user) async {
    await _repository.rememberUser(user);
  }
}
