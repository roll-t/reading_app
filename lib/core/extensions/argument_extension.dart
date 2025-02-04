extension ArgumentExtension on Map<String, dynamic> {
  dynamic getArgument(String key, {dynamic defaultValue}) {
    return containsKey(key) ? this[key] : defaultValue;
  }
}
