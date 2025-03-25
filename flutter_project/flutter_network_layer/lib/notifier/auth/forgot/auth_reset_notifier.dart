import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authResetPasswordProvider =
    StateNotifierProvider<AuthResetNotifier, AsyncValue<OnlyMessageResponse?>>((
      ref,
    ) {
      final dio = Dio();
      return AuthResetNotifier(AuthRepository(dio));
    });

class AuthResetNotifier
    extends StateNotifier<AsyncValue<OnlyMessageResponse?>> {
  final AuthRepository _authRepository;
  AuthResetNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> resetPassword(
    String token,
    String email,
    String password,
    String repassword,
  ) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.resetPassword(
        token,
        email,
        password,
        repassword,
      );
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
