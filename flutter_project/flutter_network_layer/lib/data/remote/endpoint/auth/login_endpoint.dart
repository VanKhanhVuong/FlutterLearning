import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class LoginEndPoint extends NetworkLayerConfigure<AuthResponse> {
  final String email;
  final String password;

  LoginEndPoint({required this.email, required this.password});

  @override
  String get path => "/api/login";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Map<String, dynamic> get httpBody => {"email": email, "password": password};
}
