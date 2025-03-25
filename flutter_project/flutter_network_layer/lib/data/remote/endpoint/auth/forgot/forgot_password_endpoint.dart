import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';

class ForgotPasswordEndpoint
    extends NetworkLayerConfigure<OnlyMessageResponse> {
  final String email;

  ForgotPasswordEndpoint({required this.email});

  @override
  String get path => "/api/forgot/password";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get httpHeaderFields => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Map<String, dynamic> get httpBody => {"email": email};
}
