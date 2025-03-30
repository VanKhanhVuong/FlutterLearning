import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/flash_card.dart';

class CreateFlashCardEndpoint extends NetworkLayerConfigure<FlashCardResponse> {
  final String accessToken;
  final String question;
  final String answer;

  CreateFlashCardEndpoint({
    required this.accessToken,
    required this.question,
    required this.answer,
  });

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  String get path => "/api/add/flashcard";

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $accessToken",
  };

  @override
  Map<String, dynamic> get httpBody => {"question": question, "answer": answer};
}
