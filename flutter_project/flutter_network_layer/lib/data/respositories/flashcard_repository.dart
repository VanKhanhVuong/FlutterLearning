import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint/flash_card/create_flash_card.dart';
import 'package:flutter_network_layer/data/remote/endpoint/flash_card/edit_flash_card.dart';
import 'package:flutter_network_layer/data/remote/endpoint/flash_card/get_item_flash_card.dart';
import 'package:flutter_network_layer/data/remote/endpoint/flash_card/get_list_flash_card.dart';

import 'package:flutter_network_layer/domain/entities/flash_card.dart';

class FlashcardRepository {
  final Dio _dio;

  FlashcardRepository(this._dio);

  Future<FlashCardsResponse> getFlashCards(String accessToken) async {
    final endpoint = GetListFlashCardEndpoint(accessToken: accessToken);
    try {
      final response = await _dio.get(
        endpoint.url,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return FlashCardsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Get flashcards failed");
    }
  }

  Future<FlashCardResponse> getFlashCardById(
    String accessToken,
    String flashcardId,
  ) async {
    final endpoint = GetItemFlashCardEndpoint(
      accessToken: accessToken,
      flashcardId: flashcardId,
    );
    try {
      final response = await _dio.get(
        endpoint.url,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return FlashCardResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Get Flash Card by id failed",
      );
    }
  }

  Future<void> createFlashCard(
    String accessToken,
    String question,
    String answer,
  ) async {
    final endpoint = CreateFlashCardEndpoint(
      accessToken: accessToken,
      question: question,
      answer: answer,
    );
    try {
      await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Create FlashCard failed");
    }
  }

  Future<void> editFlashCardById(
    String accessToken,
    String flashcardId,
    String question,
    String answer,
  ) async {
    final endpoint = EditFlashCardWithIdEndpoint(
      accessToken: accessToken,
      question: question,
      answer: answer,
      flashcardId: flashcardId,
    );
    try {
      await _dio.post(
        endpoint.url,
        data: endpoint.httpBody,
        options: Options(headers: endpoint.httpHeaderFields),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Edit FlashCard failed");
    }
  }
}
