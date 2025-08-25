import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio;
  final _storage = FlutterSecureStorage();

  ApiService._internal()
      : _dio = Dio(BaseOptions(
          baseUrl: dotenv.env['BASE_URL']! ,
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) {
        // bisa tambahkan refresh token logika di sini
        return handler.next(e);
      },
    ));
  }

  static final ApiService _instance = ApiService._internal();

  static ApiService get instance => _instance;

  Dio get client => _dio;
}
