import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

final authLoginProvider =
    StateNotifierProvider<AuthLoginNotifier, AsyncValue<AuthResponse?>>((ref) {
      final dio = Dio();
      return AuthLoginNotifier(AuthRepository(dio));
    });

class AuthLoginNotifier extends StateNotifier<AsyncValue<AuthResponse?>> {
  final AuthRepository _authRepository;
  AuthLoginNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.login(email, password);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
