import 'package:reading_app/core/services/api/data/entities/dto/request/user_request.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';

abstract class UserRepository {  
  Future<UserModel?> fetchUser(String uid);
  Future<UserModel?> signInWithGoogle(UserRequest request);
  Future<void> setUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> rememberUser(UserModel user);
  Future<UserModel?> getRememberUser();
}
