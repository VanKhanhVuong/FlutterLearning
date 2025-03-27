class OpenAiResponse {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;

  OpenAiResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory OpenAiResponse.fromMap(Map<String, dynamic> json) => OpenAiResponse(
    id: json["id"] ?? "",
    object: json["object"] ?? "",
    created: json["created"] ?? 0,
    model: json["model"] ?? "",
    choices:
        json["choices"] != null
            ? List<Choice>.from(json["choices"].map((x) => Choice.fromMap(x)))
            : [],
    usage: json["usage"] != null ? Usage.fromMap(json["usage"]) : Usage.zero(),
  );
}

class Choice {
  final int index;
  final Message message;
  final String finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory Choice.fromMap(Map<String, dynamic> json) => Choice(
    index: json["index"] ?? 0,
    message: Message.fromMap(json["message"] ?? {}),
    finishReason: json["finish_reason"] ?? "",
  );
}

class Message {
  final String role;
  final String content;

  Message({required this.role, required this.content});

  factory Message.fromMap(Map<String, dynamic> json) =>
      Message(role: json["role"] ?? "", content: json["content"] ?? "");
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromMap(Map<String, dynamic> json) => Usage(
    promptTokens: json["prompt_tokens"] ?? 0,
    completionTokens: json["completion_tokens"] ?? 0,
    totalTokens: json["total_tokens"] ?? 0,
  );

  factory Usage.zero() =>
      Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0);
}
