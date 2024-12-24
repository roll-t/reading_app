class NumberUtils {
  static String formatFavoriteCount(int number) {
    if (number >= 1000) {
      double formattedNumber = number / 1000;
      if (formattedNumber == formattedNumber.toInt()) {
        return "${formattedNumber.toInt()}k";
      } else {
        return "${formattedNumber.toStringAsFixed(1)}k";
      }
    } else {
      return number.toString();
    }
  }
}
