import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/notifier/auth/auth_logout_notifier.dart';
import 'package:flutter_network_layer/screens/auth/user_info.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_network_layer/screens/auth/welcome.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final errorFeedback = useState<String?>(null);
    final isLoading = useState<bool>(false);
    final secureStorage = SecureStorage();

    return Consumer(
      builder: (context, ref, child) {
        final authNotifier = ref.read(authLogoutProvider.notifier);

        Future<void> handleLogout() async {
          errorFeedback.value = null;
          isLoading.value = true;

          try {
            final accessToken = await secureStorage.readSecureData(
              'accessToken',
            );
            debugPrint("Token before deletion: $accessToken");

            await authNotifier.logout(accessToken);
            await secureStorage.deleteSecureData('email');
            await secureStorage.deleteSecureData('accessToken');

            ref.invalidate(authLogoutProvider);
            final tokenAfterDeletion = await secureStorage.readSecureData(
              'accessToken',
            );
            debugPrint("Token after deletion: $tokenAfterDeletion");

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            });
          } catch (error) {
            errorFeedback.value = error.toString();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.toString())));
          } finally {
            isLoading.value = false;
          }
        }

        Future<void> handleUserInfo() async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserInfo()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const StyledAppBarText('Setting Screen'),
            backgroundColor: Colors.blue[500],
            centerTitle: true,
          ),
          body: ListView(
            children: [
              _buildMenuItem(context, 'Logout', Icons.logout, () async {
                await handleLogout();
              }),
              _buildMenuItem(context, "User Info", Icons.person, () async {
                await handleUserInfo();
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
