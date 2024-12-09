class StringUtils {
  // Bản đồ lưu trữ các từ tiếng Anh và bản dịch tiếng Việt
  static const Map<String, String> _translations = {
    'OPENING': 'Đang phát hành',
    'AVAILABLE': 'Phổ biến',
    'CANCELLED': 'Đã hủy',
    'COMPLETED': 'Hoàn thành',
    'ON_HOLD': 'Tạm dừng',
    'SLIDER': 'Quảng cáo',
    'ongoing': 'Đang phát hành',
    'available': 'Phổ biến',
    'cancelled': 'Đã hủy',
    'coming_soon': 'sắp ra mắt',
    'completed': 'Hoàn thành',
    'on_hold': 'Tạm dừng',
    'slider': 'Quảng cáo',
  };

  static String translate(String input) {
    List<String> words = input.split(' ');

    List<String> translatedWords = [];

    for (String word in words) {
      if (_translations.containsKey(word)) {
        translatedWords.add(_translations[word]!);
      } else {
        translatedWords.add(word);
      }
    }

    return translatedWords.join(' ');
  }
}
