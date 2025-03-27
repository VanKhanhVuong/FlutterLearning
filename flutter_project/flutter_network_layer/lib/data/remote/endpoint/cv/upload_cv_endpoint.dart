import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/cv.dart';

class UploadFileEndpoint extends NetworkLayerConfigure<CvModel> {
  final String accessToken;
  final File file;

  UploadFileEndpoint({required this.accessToken, required this.file});

  @override
  String get path => "/api/parse/file";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Authorization": "Bearer $accessToken",
  };

  @override
  FormData get httpBody {
    return FormData.fromMap({
      "file": MultipartFile.fromFileSync(
        file.path,
        filename: file.path.split('/').last,
      ),
    });
  }
}
