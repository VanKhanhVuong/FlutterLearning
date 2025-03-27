import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/open_ai_repository.dart';
import 'package:flutter_network_layer/domain/entities/open_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tạo provider cho Dio để tái sử dụng
final dioProvider = Provider<Dio>((ref) => Dio());

// Provider cho OpenAiRepository, giúp chia tách dependencies
final openAiRepositoryProvider = Provider<OpenAiRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return OpenAiRepository(dio);
});

// Provider cho GenerateCompletionNotifier
final generateCompletionProvider = StateNotifierProvider<
  GenerateCompletionNotifier,
  AsyncValue<OpenAiResponse?>
>((ref) {
  final repository = ref.watch(openAiRepositoryProvider);
  return GenerateCompletionNotifier(repository);
});

class GenerateCompletionNotifier
    extends StateNotifier<AsyncValue<OpenAiResponse?>> {
  final OpenAiRepository _openAiRepository;

  GenerateCompletionNotifier(this._openAiRepository)
    : super(const AsyncValue.data(null));

  Future<void> generateCompletion(
    String systemMessage,
    String userMessage,
    String apikey,
  ) async {
    state = const AsyncValue.loading();

    try {
      final response = await _openAiRepository.generateCompletion(
        systemMessage,
        userMessage,
        apikey,
      );
      state = AsyncValue.data(response);
    } on Exception catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
