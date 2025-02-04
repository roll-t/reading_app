
import 'package:reading_app/core/services/api/domain/repositories/theme_repository.dart';

class SetFontUseCase {
  final ThemeRepository _repository;

  SetFontUseCase(this._repository);

  Future<void> call(String font) async {
    try {
      await _repository.setFont(font);
    } catch (e) {
      print('Error setting font: $e');
    }
  }
}
