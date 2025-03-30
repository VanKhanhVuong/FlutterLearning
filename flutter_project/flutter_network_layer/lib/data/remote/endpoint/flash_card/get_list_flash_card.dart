import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/flash_card.dart';

class GetListFlashCardEndpoint
    extends NetworkLayerConfigure<FlashCardsResponse> {
  final String accessToken;

  GetListFlashCardEndpoint({required this.accessToken});

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String get path => "/api/flashcards";

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $accessToken",
  };
}
