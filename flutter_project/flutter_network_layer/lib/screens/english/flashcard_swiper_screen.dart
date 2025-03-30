import 'package:flutter/material.dart';
import 'package:flutter_network_layer/notifier/flashcard/flashcard_notifier.dart';
import 'package:flutter_network_layer/domain/entities/flash_card.dart';
// import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashCardSwiperScreen extends ConsumerWidget {
  const FlashCardSwiperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashCardState = ref.watch(getListFlashCardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards")),
      body: flashCardState.when(
        data: (flashCardsResponse) {
          final flashCards = flashCardsResponse?.flashcardsData ?? [];

          if (flashCards.isEmpty) {
            return const Center(child: Text("No flashcards available"));
          }

          return PageView.builder(
            itemCount: flashCards.length,
            itemBuilder: (context, index) {
              final flashCard = flashCards[index];
              return FlashCardWidget(flashCard: flashCard);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}

class FlashCardWidget extends StatefulWidget {
  final FlashCard flashCard;

  const FlashCardWidget({super.key, required this.flashCard});

  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  bool _isFront = true;

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (widget, animation) {
          final rotate = Tween(begin: 1.0, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: widget,
            builder: (context, child) {
              final angle = rotate.value * 3.14;
              return Transform(
                transform: Matrix4.rotationY(angle),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        child:
            _isFront
                ? FlashCardFace(
                  key: const ValueKey(true),
                  text: widget.flashCard.question,
                  color: Colors.blueAccent,
                )
                : FlashCardFace(
                  key: const ValueKey(false),
                  text: widget.flashCard.answer,
                  color: Colors.orangeAccent,
                ),
      ),
    );
  }
}

class FlashCardFace extends StatelessWidget {
  final String text;
  final Color color;

  const FlashCardFace({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
