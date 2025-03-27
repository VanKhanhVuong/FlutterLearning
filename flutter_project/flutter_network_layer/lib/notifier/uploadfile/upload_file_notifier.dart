import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/upload_file_repository.dart';
import 'package:flutter_network_layer/domain/entities/cv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadFileProvider =
    StateNotifierProvider<UploadFileEndpoint, AsyncValue<CvModel?>>((ref) {
      final dio = Dio();
      return UploadFileEndpoint(UploadFileRepository(dio));
    });

class UploadFileEndpoint extends StateNotifier<AsyncValue<CvModel?>> {
  final UploadFileRepository _uploadFileRepository;
  UploadFileEndpoint(this._uploadFileRepository)
    : super(const AsyncValue.data(null));

  Future<void> upload(String accessToken, File file) async {
    state = const AsyncValue.loading();
    try {
      final response = await _uploadFileRepository.uploadFile(
        accessToken,
        file,
      );
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
