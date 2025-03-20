import 'package:flutter_network_layer/domain/entities/post.dart';
import 'package:flutter_network_layer/data/remote/endpoint.dart';

class PostsEndpoint extends NetworkLayerConfigure<PostResponse> {
  @override
  String get baseURL => 'https://shop.vankhanhvuong.com';

  @override
  String get path => "/api/posts";

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  HTTPMethod get method => HTTPMethod.get;
}
