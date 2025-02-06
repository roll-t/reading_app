import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/request/user_request.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/auth_service.dart';
import 'package:reading_app/core/services/api/data/sources/locals/user_service.dart';
import 'package:reading_app/core/services/api/domain/usecase/auths/set_token_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/users/set_user_usecase.dart';
import 'package:reading_app/features/auth/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  //service
  final GoogleSignIn _googleSignIn;
  final AuthService _authService;
  final UserService _userService;

  //usecase
  final SetTokenUsecase _setTokenUsecase;
  final SetUserUsecase _setUserUsecase;

  LoginRepositoryImpl(this._googleSignIn, this._authService, this._userService,
      this._setTokenUsecase, this._setUserUsecase);

  @override
  Future<UserModel?> googleSignIn() async {
    await _googleSignIn.signOut();
    final account = await _googleSignIn.signIn();
    if (account == null) return null;
    final userLogin = UserRequest(
      uid: account.id,
      displayName: account.displayName,
      email: account.email,
      photoURL: account.photoUrl,
    );

    // Kiểm tra nếu người dùng chưa tồn tại
    final userExists = await _userService.fetchUser(uid: account.id);
    if (userExists == null || userExists.status == Status.error) {
      final response = await _userService.signInAPI(userRequest: userLogin);
      if (response?.status == Status.success) {
        if (response?.data == null) return null;
        return await signin(
            response?.data?.email ?? "", response?.data?.password ?? "0123456");
      }
    }

    // Nếu người dùng đã tồn tại
    if (userExists?.status == Status.success) {
      return await signin(userExists?.data?.email ?? "",
          userExists?.data?.password ?? "0123456");
    }
    return null;
  }

  @override
  Future<UserModel?> signin(String email, String password) async {
    final Result<AuthenticationModel>? auth = await _authService.token(
      userModel: UserModel(
        email: email.trim(),
        password: password.trim(),
      ),
    );
    if (auth != null && auth.status == Status.success) {
      var decodedToken = JwtDecoder.decode(auth.data?.token ?? "");
      final user = UserModel(
        email: decodedToken['sub'],
        displayName: decodedToken['displayName'],
        photoURL: decodedToken['photoURL'] ?? "",
      );
      _setUserUsecase(user);
      _setTokenUsecase(auth.data?.token ?? "");
      return user;
    } else {
      throw Exception("Authentication failed");
    }
  }

  @override
  Future<bool> emailExits(String email) async {
    final result = await _userService.fetchEmailExist(email: email.trim());
    return result.data == true;
  }
}
