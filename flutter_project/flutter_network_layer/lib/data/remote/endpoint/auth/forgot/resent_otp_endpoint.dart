import 'package:flutter_network_layer/data/remote/endpoint.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';

class ResentOTPEndpoint extends NetworkLayerConfigure<OnlyMessageResponse> {
  final String email;

  ResentOTPEndpoint({required this.email});

  @override
  String get path => "/api/resend/otp/reset/password";

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
