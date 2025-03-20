import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class RefreshEndPoint extends NetworkLayerConfigure<AuthResponse> {
  final String email;
  final String accessToken;

  RefreshEndPoint({required this.email, required this.accessToken});

  @override
  String get path => "/api/refresh";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $accessToken",
  };

  @override
  Map<String, dynamic> get httpBody => {"email": email};
}
