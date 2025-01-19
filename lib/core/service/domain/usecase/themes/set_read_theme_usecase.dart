import 'package:reading_app/core/service/domain/repositories/theme_repository.dart';

class SetReadThemeUseCase {
  final ThemeRepository _repository;

  SetReadThemeUseCase(this._repository);

  Future<void> call(Map<String, dynamic> readThemeSetting) async {
    try {
      await _repository.setReadTheme(readThemeSetting);
    } catch (e) {
      print('Error setting read theme: $e');
    }
  }
}
