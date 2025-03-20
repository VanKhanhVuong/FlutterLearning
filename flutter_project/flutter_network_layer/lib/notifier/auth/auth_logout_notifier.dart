import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

final authLogoutProvider =
    StateNotifierProvider<AuthLogoutNotifier, AsyncValue<OnlyMessageResponse?>>(
      (ref) {
        final dio = Dio();
        return AuthLogoutNotifier(AuthRepository(dio));
      },
    );

class AuthLogoutNotifier
    extends StateNotifier<AsyncValue<OnlyMessageResponse?>> {
  final AuthRepository _authRepository;
  AuthLogoutNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> logout(String accessToken) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.logout(accessToken);
      state = AsyncValue.data(response);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
