import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class UserEndPoint extends NetworkLayerConfigure<UserResponse> {
  final String accessToken;

  UserEndPoint({required this.accessToken});

  @override
  String get path => "/api/user";

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $accessToken",
  };
}
