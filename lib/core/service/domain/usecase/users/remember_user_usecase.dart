import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/service/domain/repositories/user_repository.dart';

/// UseCase: Remember user
class RememberUserUsecase {
  final UserRepository _repository;

  RememberUserUsecase(this._repository);

  Future<void> call(UserModel user) async {
    try {
      await _repository.rememberUser(user);
    } catch (e) {
      print("Error remembering user: $e");
    }
  }
}
