import 'package:reading_app/core/services/api/domain/repositories/theme_repository.dart';

class GetReadThemeUseCase {
  final ThemeRepository _repository;

  GetReadThemeUseCase(this._repository);

  Future<Map<String, dynamic>?> call() async {
    try {
      return await _repository.getReadTheme();
    } catch (e) {
      print('Error getting read theme: $e');
      return null;
    }
  }
}
