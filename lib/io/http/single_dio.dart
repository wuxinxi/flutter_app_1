import 'package:dio/dio.dart';

class DioFactory {
  factory DioFactory() => _getInstance();

  static DioFactory get instance => _getInstance();
  static DioFactory _instance;

  Dio dio;

  DioFactory._internal() {
    dio = Dio();
  }

  static DioFactory _getInstance() {
    if (_instance == null) {
      _instance = DioFactory._internal();
    }
    return _instance;
  }
}
