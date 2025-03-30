import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/flash_card.dart';

class GetItemFlashCardEndpoint
    extends NetworkLayerConfigure<FlashCardResponse> {
  final String accessToken;
  final String flashcardId;

  GetItemFlashCardEndpoint({
    required this.accessToken,
    required this.flashcardId,
  });

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => "/api/flashcard/detail/$flashcardId";

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $accessToken",
  };
}
