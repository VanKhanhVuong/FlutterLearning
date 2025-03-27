import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint/openapi/generate_completions_endpoint.dart';
import 'package:flutter_network_layer/domain/entities/open_ai.dart';

class OpenAiRepository {
  final Dio _dio;

  OpenAiRepository(this._dio);

  Future<OpenAiResponse> generateCompletion(
    String systemMessage,
    String userMessage,
    String apikey,
  ) async {
    final endpoint = GenerateCompletionsEndpoint(
      systemMessage: systemMessage,
      userMessage: userMessage,
      apiKey: apikey,
    );

    try {
      final response = await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        return OpenAiResponse.fromMap(response.data);
      } else {
        throw Exception("Invalid response from OpenAI");
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data is Map<String, dynamic>
              ? e.response?.data["message"] ?? "Completion failed"
              : "Completion failed";
      throw Exception(errorMessage);
    }
  }
}
