import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authResentPasswordProvider =
    StateNotifierProvider<AuthResentNotifier, AsyncValue<OnlyMessageResponse?>>(
      (ref) {
        final dio = Dio();
        return AuthResentNotifier(AuthRepository(dio));
      },
    );

class AuthResentNotifier
    extends StateNotifier<AsyncValue<OnlyMessageResponse?>> {
  final AuthRepository _authRepository;
  AuthResentNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> resentOTPForgotPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.resentPassword(email);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
