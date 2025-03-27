import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/open_ai.dart';

class GenerateCompletionsEndpoint
    extends NetworkLayerConfigure<OpenAiResponse> {
  final String systemMessage;
  final String userMessage;
  final String apiKey;
  final double temperature;
  final String model;

  GenerateCompletionsEndpoint({
    required this.systemMessage,
    required this.userMessage,
    required this.apiKey,
    this.temperature = 0.7, // Config độ sáng tạo
    this.model = "gpt-4o-mini", // Mặc định là gpt-4o, có thể thay đổi
  });

  @override
  String get baseURL => 'https://api.openai.com/v1';

  @override
  String get path => "/chat/completions";

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey",
  };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, dynamic>? get httpBody => {
    "model": model,
    "messages": [
      {"role": "system", "content": systemMessage},
      {"role": "user", "content": userMessage},
    ],
    "max_tokens": 2480,
    "temperature": temperature,
  };

  /// 🔹 Tạo bản sao với model khác (VD: gpt-4o-mini)
  GenerateCompletionsEndpoint copyWithModel(String newModel) {
    return GenerateCompletionsEndpoint(
      systemMessage: systemMessage,
      userMessage: userMessage,
      apiKey: apiKey,
      temperature: temperature,
      model: newModel,
    );
  }
}
