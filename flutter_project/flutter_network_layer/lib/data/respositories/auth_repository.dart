import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/login_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/logout_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/register_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/verify_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/refresh_token_endpoint.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponse> login(String email, String password) async {
    final endpoint = LoginEndPoint(email: email, password: password);

    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login failed");
    }
  }

  Future<AuthResponse> refresh(String email, String accessToken) async {
    final endpoint = RefreshEndPoint(email: email, accessToken: accessToken);
    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Refresh Access Token failed",
      );
    }
  }

  Future<AuthResponse> verify(String email, String code) async {
    final endpoint = VerifyEndPoint(email: email, code: code);

    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Verify failed");
    }
  }

  Future<OnlyMessageResponse> register(
    String name,
    String email,
    String password,
    String repassword,
  ) async {
    final endpoint = RegisterEndpoint(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: repassword,
    );

    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return OnlyMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Sign Up failed");
    }
  }

  Future<OnlyMessageResponse> logout(String accessToken) async {
    final endpoint = LogoutEndpoint(accessToken: accessToken);
    try {
      final response = await _dio.post(
        endpoint.url,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return OnlyMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Logout failed");
    }
  }
}
