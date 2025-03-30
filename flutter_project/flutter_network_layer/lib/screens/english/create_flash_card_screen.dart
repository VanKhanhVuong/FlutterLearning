import 'package:flutter/material.dart';
import 'package:flutter_network_layer/notifier/flashcard/flashcard_notifier.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_network_layer/providers/flashcard_providers.dart';

class CreateFlashCardScreen extends ConsumerStatefulWidget {
  const CreateFlashCardScreen({super.key});

  @override
  ConsumerState<CreateFlashCardScreen> createState() =>
      _CreateFlashCardScreenState();
}

class _CreateFlashCardScreenState extends ConsumerState<CreateFlashCardScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createFlashCardState = ref.watch(createFlashCardProvider);
    final secureStorage = SecureStorage();

    return Scaffold(
      appBar: AppBar(title: const Text('Create Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  createFlashCardState is AsyncLoading
                      ? null
                      : () async {
                        final question = _questionController.text.trim();
                        final answer = _answerController.text.trim();

                        if (question.isEmpty || answer.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                          return;
                        }

                        final accessToken = await secureStorage.readSecureData(
                          'accessToken',
                        );
                        if (accessToken.isEmpty) {
                          throw Exception("Access token is missing");
                        }

                        await ref
                            .read(createFlashCardProvider.notifier)
                            .createFlashCard(accessToken, question, answer);

                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
                      },
              child:
                  createFlashCardState is AsyncLoading
                      ? const CircularProgressIndicator()
                      : const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
