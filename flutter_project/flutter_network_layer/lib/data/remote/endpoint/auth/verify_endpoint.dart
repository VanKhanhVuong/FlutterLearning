import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

class VerifyEndPoint extends NetworkLayerConfigure<AuthResponse> {
  final String email;
  final String code;

  VerifyEndPoint({required this.email, required this.code});

  @override
  String get path => "/api/verify/email";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Map<String, dynamic> get httpBody => {"email": email, "otp": code};
}
