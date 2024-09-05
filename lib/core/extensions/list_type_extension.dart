import 'package:reading_app/core/configs/enum.dart';

extension ListTypeExtension on ListType {
  String get value {
    switch (this) {
      case ListType.newRelease:
        return "truyen-moi";
      case ListType.upcoming:
        return "sap-ra-mat";
      case ListType.ongoing:
        return "dang-phat-hanh";
      case ListType.completed:
        return "hoan-thanh";
    }
  }
  
  static ListType fromString(String value) {
    switch (value) {
      case "truyen-moi":
        return ListType.newRelease;
      case "sap-ra-mat":
        return ListType.upcoming;
      case "dang-phat-hanh":
        return ListType.ongoing;
      case "hoan-thanh":
        return ListType.completed;
      default:
        throw ArgumentError("Invalid value: $value");
    }
  }
}
