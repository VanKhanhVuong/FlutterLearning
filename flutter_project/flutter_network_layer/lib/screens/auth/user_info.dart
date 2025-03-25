import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_network_layer/notifier/auth/auth_user_info_notifier.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';

class UserInfo extends ConsumerStatefulWidget {
  const UserInfo({super.key});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends ConsumerState<UserInfo> {
  bool isLoading = false;
  String? errorFeedback;

  @override
  void initState() {
    super.initState();
    _handleGetUserInfo(); // Gọi API ngay khi vào màn hình
  }

  Future<void> _handleGetUserInfo() async {
    final authUserInfoNotifier = ref.read(authUserInfoProvider.notifier);
    final secureStorage = SecureStorage();
    setState(() {
      isLoading = true;
      errorFeedback = null;
    });

    try {
      final accessToken = await secureStorage.readSecureData('accessToken');
      if (accessToken.isEmpty) {
        throw Exception("Access token is missing");
      }
      await authUserInfoNotifier.userInfo(accessToken);
    } catch (error) {
      setState(() {
        errorFeedback = error.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUserInfoState = ref.watch(authUserInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('User Information'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: StyledBodyText('User Information')),
            const SizedBox(height: 16.0),
            if (errorFeedback != null)
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      "Error: $errorFeedback",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            authUserInfoState.when(
              data: (authResponse) {
                if (authResponse == null ||
                    authResponse.user.toString().isEmpty) {
                  return const Center(
                    child: StyledBodyText('No user data available'),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StyledBodyText('Email: ${authResponse.user.email}'),
                    const SizedBox(height: 16.0),
                    StyledBodyText('Role: ${authResponse.user.role}'),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                return Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 40),
                      const SizedBox(height: 10),
                      Text(
                        "Error: ${error.toString()}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
