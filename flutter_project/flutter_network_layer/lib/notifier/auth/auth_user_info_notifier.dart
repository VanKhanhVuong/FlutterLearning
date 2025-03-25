import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_network_layer/domain/entities/user.dart';

final authUserInfoProvider =
    StateNotifierProvider<AuthUserInfoNotifier, AsyncValue<UserResponse?>>((
      ref,
    ) {
      final dio = Dio();
      return AuthUserInfoNotifier(AuthRepository(dio));
    });

class AuthUserInfoNotifier extends StateNotifier<AsyncValue<UserResponse?>> {
  final AuthRepository _authRepository;
  AuthUserInfoNotifier(this._authRepository)
    : super(const AsyncValue.data(null));

  Future<void> userInfo(String accessToken) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.userInfo(accessToken);
      state = AsyncValue.data(response);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
