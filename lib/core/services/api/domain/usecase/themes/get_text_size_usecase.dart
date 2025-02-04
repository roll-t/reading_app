import 'package:reading_app/core/services/api/domain/repositories/theme_repository.dart';

class GetTextSizeUseCase {
  final ThemeRepository _repository;

  GetTextSizeUseCase(this._repository);

  Future<double> call() async {
    try {
      return await _repository.getTextSize();
    } catch (e) {
      print('Error getting text size: $e');
      return 10; // Default value
    }
  }
}
