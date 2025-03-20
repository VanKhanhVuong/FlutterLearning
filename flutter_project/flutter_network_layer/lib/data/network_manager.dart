import 'package:dio/dio.dart';

class DataResult {
  final String? status;
  final String? message;

  DataResult({this.status, this.message});

  factory DataResult.fromJson(Map<String, dynamic> json) {
    return DataResult(status: json['status'], message: json['message']);
  }
}

enum APIErrorHandler {
  authenticationError,
  badRequest,
  timeOut,
  gone,
  forbidden,
  unknownError,
  unableToDecode,
  noData,
  notFound,
}

extension APIErrorHandlerExtension on APIErrorHandler {
  static APIErrorHandler fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return APIErrorHandler.authenticationError;
      case 400:
        return APIErrorHandler.badRequest;
      case 410:
        return APIErrorHandler.gone;
      case 403:
        return APIErrorHandler.forbidden;
      case 408:
        return APIErrorHandler.timeOut;
      case 204:
        return APIErrorHandler.noData;
      case 404:
        return APIErrorHandler.notFound;
      default:
        return APIErrorHandler.unknownError;
    }
  }
}

class NetworkManager {
  final Dio _dio;

  NetworkManager._internal()
    : _dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(CustomInterceptor());
  }

  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;

  Future<T> request<T>(
    String url, {
    required String method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParams,
        options: Options(method: method, headers: headers),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return fromJson(response.data);
      } else {
        throw APIErrorHandlerExtension.fromStatusCode(
          response.statusCode ?? 500,
        );
      }
    } catch (error) {
      if (error is DioException) {
        throw APIErrorHandlerExtension.fromStatusCode(
          error.response?.statusCode ?? 500,
        );
      }
      throw APIErrorHandler.unknownError;
    }
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options); // Chuyển request đi tiếp
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
