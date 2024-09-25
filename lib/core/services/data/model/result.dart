import 'package:reading_app/core/configs/enum.dart';

class Result<T> {
  final Status status;
  final T? data;
  final ApiError? error;

  Result._(this.status, this.data, this.error);

  factory Result.success(T? data) {
    return Result._(Status.success, data, null);
  }

  factory Result.error(ApiError error, {T? data}) {
    return Result._(Status.error, data, error);
  }
}
