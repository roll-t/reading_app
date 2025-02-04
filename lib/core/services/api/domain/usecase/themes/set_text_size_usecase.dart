import 'package:reading_app/core/services/api/domain/repositories/theme_repository.dart';

class SetTextSizeUseCase {
  final ThemeRepository _repository;

  SetTextSizeUseCase(this._repository);

  Future<void> call(double sizeText) async {
    try {
      await _repository.setTextSize(sizeText);
    } catch (e) {
      print('Error setting text size: $e');
    }
  }
}
