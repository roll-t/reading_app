class TextFormat {
  static String capitalizeEachWord(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text.split(' ').map((word) {
      if (word == word.toUpperCase()) {
        return word;
      }

      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word;
    }).join(' ');
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
