// Created by: Văn Khánh Vương
import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/flashcard_repository.dart';
import 'package:flutter_network_layer/domain/entities/flash_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FlashcardRepository(dio);
});

final getListFlashCardProvider = StateNotifierProvider<
  GetListFlashCardNotifier,
  AsyncValue<FlashCardsResponse?>
>((ref) {
  final repository = ref.watch(flashcardRepositoryProvider);
  return GetListFlashCardNotifier(repository);
});

final getItemFlashCardProvider = StateNotifierProvider<
  GetItemFlashCardNotifier,
  AsyncValue<FlashCardResponse?>
>((ref) {
  final repository = ref.watch(flashcardRepositoryProvider);
  return GetItemFlashCardNotifier(repository);
});

final createFlashCardProvider =
    StateNotifierProvider<CreateFlashCardNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(flashcardRepositoryProvider);
      return CreateFlashCardNotifier(repository);
    });

final editFlashCardProvider =
    StateNotifierProvider<EditFlashCardNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(flashcardRepositoryProvider);
      return EditFlashCardNotifier(repository);
    });

class GetListFlashCardNotifier
    extends StateNotifier<AsyncValue<FlashCardsResponse?>> {
  final FlashcardRepository _flashcardRepository;

  GetListFlashCardNotifier(this._flashcardRepository)
    : super(const AsyncValue.data(null));

  Future<void> getListFlashCard(String accessToken) async {
    state = const AsyncValue.loading();

    try {
      final response = await _flashcardRepository.getFlashCards(accessToken);
      state = AsyncValue.data(response);
    } on Exception catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

class GetItemFlashCardNotifier
    extends StateNotifier<AsyncValue<FlashCardResponse?>> {
  final FlashcardRepository _flashcardRepository;

  GetItemFlashCardNotifier(this._flashcardRepository)
    : super(const AsyncValue.data(null));

  Future<void> getItemFlashCard(String accessToken, String flashcardId) async {
    state = const AsyncValue.loading();

    try {
      final response = await _flashcardRepository.getFlashCardById(
        accessToken,
        flashcardId,
      );
      state = AsyncValue.data(response);
    } on Exception catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

class CreateFlashCardNotifier extends StateNotifier<AsyncValue<void>> {
  final FlashcardRepository _flashcardRepository;

  CreateFlashCardNotifier(this._flashcardRepository)
    : super(const AsyncValue.data(null));

  Future<void> createFlashCard(
    String accessToken,
    String question,
    String answer,
  ) async {
    state = const AsyncValue.loading();

    try {
      await _flashcardRepository.createFlashCard(accessToken, question, answer);
      state = const AsyncValue.data(null);
    } on Exception catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

class EditFlashCardNotifier extends StateNotifier<AsyncValue<void>> {
  final FlashcardRepository _flashcardRepository;

  EditFlashCardNotifier(this._flashcardRepository)
    : super(const AsyncValue.data(null));

  Future<void> editFlashCard(
    String accessToken,
    String flashcardId,
    String question,
    String answer,
  ) async {
    state = const AsyncValue.loading();

    try {
      await _flashcardRepository.editFlashCardById(
        accessToken,
        flashcardId,
        question,
        answer,
      );
      state = const AsyncValue.data(null);
    } on Exception catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
