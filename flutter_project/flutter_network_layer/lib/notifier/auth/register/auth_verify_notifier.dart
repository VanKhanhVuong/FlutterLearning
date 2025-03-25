import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

final authVerifyProvider =
    StateNotifierProvider<AuthVerifyNotifier, AsyncValue<AuthResponse?>>((ref) {
      final dio = Dio();
      return AuthVerifyNotifier(AuthRepository(dio));
    });

class AuthVerifyNotifier extends StateNotifier<AsyncValue<AuthResponse?>> {
  final AuthRepository _authRepository;
  AuthVerifyNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> verify(String email, String code) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.verify(email, code);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
