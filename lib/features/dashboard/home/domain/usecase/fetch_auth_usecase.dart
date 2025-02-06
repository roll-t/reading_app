import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/features/dashboard/home/domain/repositories/home_repository.dart';

class FetchAuthUsecase {
  final HomeRepository _repository;
  FetchAuthUsecase(this._repository);
  Future<UserModel> call() async {
    try {
      UserModel? userModel = await _repository.fetchUser();
      return userModel ?? UserModel(email: "", displayName: "username");
    } catch (e) {
      print(e);
      return UserModel(email: "", displayName: "username");
    }
  }
}
