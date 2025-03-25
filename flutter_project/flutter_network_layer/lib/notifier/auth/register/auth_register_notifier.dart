import 'package:dio/dio.dart';
import 'package:flutter_network_layer/data/respositories/auth_repository.dart';
import 'package:flutter_network_layer/domain/entities/only_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRegisterProvider = StateNotifierProvider<
  AuthRegisterNotifier,
  AsyncValue<OnlyMessageResponse?>
>((ref) {
  final dio = Dio();
  return AuthRegisterNotifier(AuthRepository(dio));
});

class AuthRegisterNotifier
    extends StateNotifier<AsyncValue<OnlyMessageResponse?>> {
  final AuthRepository _authRepository;
  AuthRegisterNotifier(this._authRepository)
    : super(const AsyncValue.data(null));

  Future<void> register(
    String name,
    String email,
    String password,
    String repassword,
  ) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.register(
        name,
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
