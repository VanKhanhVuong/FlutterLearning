class FlashCard {
  final int id;
  final String question;
  final String answer;
  final String createdAt;
  final String updatedAt;

  FlashCard({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class FlashCardResponse {
  final bool status;
  final String message;
  final FlashCard flashcardData;

  FlashCardResponse({
    required this.status,
    required this.message,
    required this.flashcardData,
  });

  factory FlashCardResponse.fromJson(Map<String, dynamic> json) {
    return FlashCardResponse(
      status: json['status'],
      message: json['message'],
      flashcardData: json['flashcard_data'],
    );
  }
}

class FlashCardsResponse {
  final bool success;
  final String message;
  final List<FlashCard> flashcardsData;

  FlashCardsResponse({
    required this.success,
    required this.message,
    required this.flashcardsData,
  });

  factory FlashCardsResponse.fromJson(Map<String, dynamic> json) {
    return FlashCardsResponse(
      success: json['success'],
      message: json['message'],
      flashcardsData:
          (json['flashcards_data'] as List)
              .map((item) => FlashCard.fromJson(item))
              .toList(),
    );
  }
}
