import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';

class RegisterEndpoint extends NetworkLayerConfigure<OnlyMessageResponse> {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterEndpoint({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  String get path => "/api/register";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Map<String, dynamic> get httpBody => {
    "name": name,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
