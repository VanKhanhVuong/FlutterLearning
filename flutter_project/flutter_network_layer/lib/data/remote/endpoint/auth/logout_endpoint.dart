import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class LogoutEndpoint extends NetworkLayerConfigure<OnlyMessageResponse> {
  final String accessToken;
  LogoutEndpoint({required this.accessToken});

  @override
  String get path => "/api/logout";
  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $accessToken",
  };
}
