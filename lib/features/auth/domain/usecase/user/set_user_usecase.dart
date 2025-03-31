import 'package:reading_app/core/services/entities/models/user_model.dart';
import 'package:reading_app/features/auth/domain/repositories/user_repository.dart';

/// UseCase: Set user
class SetUserUsecase {
  final UserRepository _repository;

  SetUserUsecase(
    this._repository,
  );

  Future<void> call(UserModel user) async {
    await _repository.setUser(user);
  }
}
