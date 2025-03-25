import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';

class ResetPasswordEndpoint extends NetworkLayerConfigure<OnlyMessageResponse> {
  final String token;
  final String email;
  final String password;
  final String passwordConfirmation;

  ResetPasswordEndpoint({
    required this.token,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  String get path => "/api/reset/password";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Map<String, dynamic> get httpBody => {
    "token": token,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
