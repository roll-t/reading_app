import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/api/domain/repositories/user_repository.dart';

class GetUserUsecase {
  final UserRepository _repository;
  GetUserUsecase(this._repository);

  Future<UserModel?> call() async {
    try {
      print(await _repository.getUser());
      return await _repository.getUser();
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }
}
