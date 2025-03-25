import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authForgotProvider =
    StateNotifierProvider<AuthForgotNotifier, AsyncValue<OnlyMessageResponse?>>(
      (ref) {
        final dio = Dio();
        return AuthForgotNotifier(AuthRepository(dio));
      },
    );

class AuthForgotNotifier
    extends StateNotifier<AsyncValue<OnlyMessageResponse?>> {
  final AuthRepository _authRepository;
  AuthForgotNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> forgotPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.forgotPassword(email);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
