import 'package:dio/dio.dart';

abstract class IDioConfig {
  Dio get dio;
  void init();
}
