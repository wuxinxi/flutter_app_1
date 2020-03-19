import 'package:dio/dio.dart';

class DioFactory {
  factory DioFactory() => _getInstance();

  static DioFactory get instance => _getInstance();
  static DioFactory _instance;

  Dio dio;

  DioFactory._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: 'http://192.168.1.70:8082/mall/',
        connectTimeout: 10000,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        method: 'POST');
    dio = Dio();
  }

  static DioFactory _getInstance() {
    if (_instance == null) {
      _instance = DioFactory._internal();
    }
    return _instance;
  }
}
