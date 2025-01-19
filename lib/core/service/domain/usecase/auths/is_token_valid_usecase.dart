

import 'package:reading_app/core/service/domain/repositories/auth_repository.dart';

class IsTokenValidUsecase {
  final AuthRepository _repository;

  IsTokenValidUsecase(this._repository);

  Future<bool> call (String token) async{
    return await _repository.isTokenValid(token);
  }
}
