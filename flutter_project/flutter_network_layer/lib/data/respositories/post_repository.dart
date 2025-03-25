import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/remote/endpoint/post/posts_endpoint.dart';
import 'package:flutter_network_layer/domain/entities/post.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(this._dio);

  Future<PostResponse> getPosts() async {
    final endpoint = PostsEndpoint();

    try {
      final response = await _dio.get(
        endpoint.url,
        options: Options(headers: endpoint.httpHeaderFields),
      );

      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Get posts failed");
    }
  }
}
