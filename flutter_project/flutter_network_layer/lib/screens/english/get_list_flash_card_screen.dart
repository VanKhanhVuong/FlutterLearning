import 'package:flutter/material.dart';
import 'package:flutter_network_layer/notifier/flashcard/flashcard_notifier.dart';
import 'package:flutter_network_layer/screens/english/create_flash_card_screen.dart';
import 'package:flutter_network_layer/screens/english/flashcard_swiper_screen.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashCardScreen extends ConsumerStatefulWidget {
  const FlashCardScreen({super.key});

  @override
  ConsumerState<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends ConsumerState<FlashCardScreen> {
  @override
  void initState() {
    super.initState();
    final secureStorage = SecureStorage();
    Future.microtask(() async {
      final accessToken = await secureStorage.readSecureData('accessToken');
      if (accessToken.isEmpty) {
        throw Exception("Access token is missing");
      }
      ref.read(getListFlashCardProvider.notifier).getListFlashCard(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashCardsState = ref.watch(getListFlashCardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_stories),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlashCardSwiperScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: flashCardsState.when(
        data: (flashCardsResponse) {
          if (flashCardsResponse == null ||
              flashCardsResponse.flashcardsData.isEmpty) {
            return const Center(child: Text('No flashcards available'));
          }
          return ListView.builder(
            itemCount: flashCardsResponse.flashcardsData.length,
            itemBuilder: (context, index) {
              final flashCard = flashCardsResponse.flashcardsData[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(flashCard.question),
                  subtitle: Text(flashCard.answer),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldRefresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateFlashCardScreen(),
            ),
          );

          if (shouldRefresh == true) {
            ref.invalidate(getListFlashCardProvider);
            await ref
                .read(getListFlashCardProvider.notifier)
                .getListFlashCard(
                  await SecureStorage().readSecureData('accessToken'),
                );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
