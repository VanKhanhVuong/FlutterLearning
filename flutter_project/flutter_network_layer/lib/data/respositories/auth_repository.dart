import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/forgot/forgot_password_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/forgot/resent_otp_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/forgot/reset_password_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/login_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/logout_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/register/register_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/register/resent_verify_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/user_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/register/verify_endpoint.dart';
import 'package:flutter_network_layer/data/remote/endpoint/auth/refresh_token_endpoint.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<UserResponse> userInfo(String accessToken) async {
    final endpoint = UserEndPoint(accessToken: accessToken);

    try {
      final response = await _dio.get(
        endpoint.url,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "User Info failed");
    }
  }

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

  // MARK: Register Password Repository

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

  Future<OnlyMessageResponse> resentVerify(String email) async {
    final endpoint = ResentVerifyEndpoint(email: email);

    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return OnlyMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Request Resent failed");
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

  // MARK: Forgot Password Repository

  Future<OnlyMessageResponse> forgotPassword(String email) async {
    final endpoint = ForgotPasswordEndpoint(email: email);
    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return OnlyMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Request Forgot Failed");
    }
  }

  Future<OnlyMessageResponse> resentPassword(String email) async {
    final endpoint = ResentOTPEndpoint(email: email);
    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return OnlyMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Request Resent Failed");
    }
  }

  Future<OnlyMessageResponse> resetPassword(
    String token,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final endpoint = ResetPasswordEndpoint(
      token: token,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return OnlyMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Request Reset Failed");
    }
  }
}
