import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint/cv/upload_cv_endpoint.dart';
import 'package:flutter_network_layer/domain/entities/cv.dart';

class UploadFileRepository {
  final Dio _dio;

  UploadFileRepository(this._dio);

  Future<CvModel> uploadFile(String accessToken, File file) async {
    final endpoint = UploadFileEndpoint(accessToken: accessToken, file: file);

    try {
      final response = await _dio.post(
        endpoint.url,
        data: await endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );
      return CvModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data?["message"] ?? "Upload file failed";
      throw Exception(errorMessage);
    }
  }
}
