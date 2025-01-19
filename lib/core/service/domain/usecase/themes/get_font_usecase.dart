import 'package:reading_app/core/configs/const/app_constants.dart';
import 'package:reading_app/core/service/domain/repositories/theme_repository.dart';

class GetFontUseCase {
  final ThemeRepository _repository;

  GetFontUseCase(this._repository);

  Future<String> call() async {
    try {
      return await _repository.getFont();
    } catch (e) {
      print('Error getting font: $e');
      return AppConstants.fontDefault;
    }
  }
}
