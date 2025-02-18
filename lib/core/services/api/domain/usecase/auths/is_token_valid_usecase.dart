

import 'package:reading_app/core/services/api/domain/repositories/auth_repository.dart';

class IsTokenValidUsecase {
  final AuthRepository _repository;

  IsTokenValidUsecase(this._repository);

  Future<bool> call (String token) async{
    return await _repository.isTokenValid(token);
  }
}
