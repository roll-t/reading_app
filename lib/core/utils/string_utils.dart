class StringUtils {
  // A map to store the English words and their Vietnamese translations
  static const Map<String, String> _translations = {
    'OPENING': 'Đang phát hành',
    'AVAILABLE': 'Có sẳn',
    'CANCELLED': 'Đã hủy',
    'COMPLETED': 'Hoàn thành',
    'ON_HOLD': 'Tạm dừng',
    // Add more translations as needed
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
