abstract class ThemeRepository {
  Future<void> setReadTheme(Map<String, dynamic> readThemeSetting);
  Future<Map<String, dynamic>?> getReadTheme();
  Future<void> setTextSize(double sizeText);
  Future<double> getTextSize();
  Future<void> setFont(String font);
  Future<String> getFont();
}
