import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/service/domain/repositories/user_repository.dart';

/// UseCase: Set user
class SetUserUsecase {
  final UserRepository _repository;

  SetUserUsecase(this._repository);

  Future<void> call(UserModel user) async {
    try {
      await _repository.setUser(user);
    } catch (e) {
      print("Error setting user: $e");
    }
  }
}