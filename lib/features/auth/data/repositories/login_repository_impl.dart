import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/entities/dto/request/user_request.dart';
import 'package:reading_app/core/services/entities/models/user_model.dart';
import 'package:reading_app/features/auth/data/sources/auth_service.dart';
import 'package:reading_app/features/auth/data/sources/user_service.dart';
import 'package:reading_app/features/auth/domain/repositories/login_repository.dart';
import 'package:reading_app/features/auth/domain/usecase/user/set_token_usecase.dart';
import 'package:reading_app/features/auth/domain/usecase/user/set_user_usecase.dart';

/// Implements user login repository.
class LoginRepositoryImpl implements LoginRepository {
  final GoogleSignIn _googleSignIn;
  final AuthService _authService;
  final UserService _userService;
  final SetTokenUsecase _setTokenUsecase;
  final SetUserUsecase _setUserUsecase;

  LoginRepositoryImpl(
    this._googleSignIn,
    this._authService,
    this._userService,
    this._setTokenUsecase,
    this._setUserUsecase,
  );

  @override
  Future<UserModel?> googleSignIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final userRequest = UserRequest(
      uid: account.id,
      displayName: account.displayName,
      email: account.email,
      photoURL: account.photoUrl,
    );

    final userExists = await _userService.fetchUser(uid: account.id);

    if (userExists?.status == Status.error || userExists?.data == null) {
      final response = await _userService.signInAPI(userRequest: userRequest);
      return response?.status == Status.success
          ? await _authenticate(response?.data)
          : null;
    }

    return await _authenticate(userExists?.data);
  }

  Future<UserModel?> _authenticate(UserModel? user) async {
    if (user == null) return null;
    return await signin(user.email, user.password ?? "0123456");
  }

  @override
  Future<UserModel?> signin(String email, String password) async {
    final auth = await _authService.token(
      userModel: UserModel(email: email.trim(), password: password.trim()),
    );

    if (auth?.status != Status.success) {
      throw Exception("Authentication failed");
    }

    final decodedToken = JwtDecoder.decode(auth?.data?.token ?? "");
    final user = UserModel(
      uid: decodedToken['uid'],
      email: decodedToken['sub'],
      displayName: decodedToken['displayName'],
      photoURL: decodedToken['photoURL'] ?? "",
    );

    _setUserUsecase(user);
    _setTokenUsecase(auth?.data?.token ?? "");
    return user;
  }

  @override
  Future<bool> emailExits(String email) async {
    return (await _userService.fetchEmailExist(email: email.trim())).data ??
        false;
  }
}
