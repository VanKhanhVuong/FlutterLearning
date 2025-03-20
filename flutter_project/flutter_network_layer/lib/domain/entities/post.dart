class Post {
  final int id;
  final String name;
  final String description;
  final String image;
  final String createdAt;
  final String updatedAt;

  Post({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PostResponse {
  final bool status;
  final String message;
  final List<Post> data;

  PostResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List).map((item) => Post.fromJson(item)).toList(),
    );
  }
}
