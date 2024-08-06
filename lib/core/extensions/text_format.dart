class TextFormat {
  static String capitalizeEachWord(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text.split(' ').map((word) {
      // Kiểm tra nếu từ đã viết hoa hoàn toàn
      if (word == word.toUpperCase()) {
        return word; // Giữ nguyên từ nếu đã viết hoa hoàn toàn
      }

      // Viết hoa chữ cái đầu tiên và chuyển các chữ còn lại thành chữ thường
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word;
    }).join(' ');
  }

  static String capitalizeFirstLetter(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
