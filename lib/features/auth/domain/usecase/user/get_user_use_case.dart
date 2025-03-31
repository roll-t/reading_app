import 'package:reading_app/core/services/entities/models/user_model.dart';
import 'package:reading_app/features/auth/domain/repositories/user_repository.dart';

class GetuserUseCase {
  final UserRepository _repository;

  GetuserUseCase(this._repository);

  Future<UserModel?> call() async {
    try {
      return await _repository.getUser();
    } catch (e) {
      print("Error getting remembered user: $e");
      return null;
    }
  }
}
