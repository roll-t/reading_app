import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/api/domain/repositories/user_repository.dart';

class GetRememberedUserUsecase {
  final UserRepository _repository;

  GetRememberedUserUsecase(this._repository);

  Future<UserModel?> call() async {
    try {
      return await _repository.getRememberUser();
    } catch (e) {
      print("Error getting remembered user: $e");
      return null;
    }
  }
}
