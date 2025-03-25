class OnlyMessageResponse {
  final bool success;
  final String message;

  OnlyMessageResponse({required this.success, required this.message});

  factory OnlyMessageResponse.fromJson(Map<String, dynamic> json) {
    return OnlyMessageResponse(
      message: json['message'],
      success: json['success'],
    );
  }
}
