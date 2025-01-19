import 'package:reading_app/core/service/data/dto/request/user_request_model.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';

abstract class UserRepository {  
  Future<UserModel?> fetchUser(String uid);
  Future<UserModel?> signInWithGoogle(UserRequestModel request);
  Future<void> setUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> rememberUser(UserModel user);
  Future<UserModel?> getRememberUser();
}
