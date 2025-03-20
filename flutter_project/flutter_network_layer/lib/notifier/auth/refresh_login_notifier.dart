import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

final authRefreshProvider =
    StateNotifierProvider<AuthRefreshNotifier, AsyncValue<AuthResponse?>>((
      ref,
    ) {
      final dio = Dio();
      return AuthRefreshNotifier(AuthRepository(dio));
    });

class AuthRefreshNotifier extends StateNotifier<AsyncValue<AuthResponse?>> {
  final AuthRepository _authRepository;
  AuthRefreshNotifier(this._authRepository)
    : super(const AsyncValue.data(null));

  Future<void> refreshToken(String email, String accessToken) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.refresh(email, accessToken);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
