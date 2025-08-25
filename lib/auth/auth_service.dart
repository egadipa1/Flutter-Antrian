import 'dart:convert';

import 'package:antrian/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  final Dio dio = ApiService.instance.client;
  final secureStorage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      if (response.data['status']){
        final token = response.data['token'];
        final user = response.data['user'];

        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(
          key: 'user',
          value: jsonEncode(user), // simpan user dalam format JSON string
        );

        return true; // Login berhasil
      }
      return false; // Login gagal
    } on DioException catch (e) {
      print('Login error: ${e.response?.data}');
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }

  Future<String> signup(String email, String password, String username, String phone) async {
    try { 
      final response = await dio.post('/signup', data: {
        'name' : username,
        'phone': phone,
        'email': email,
        'password': password,
      });

      if (response.data['status']) {
        return ''; // Berhasil signup
      } else {
        return response.data['message'] ?? 'Signup failed'; // Pesan error
      }
    } on DioException catch (e) {
      print('Signup error: ${e.response?.data}');
      return e.response?.data['message'] ?? 'Signup failed';
    } catch (e) {
      print('Unexpected error: $e');
      return 'An unexpected error occurred';
    }
  }
}