import 'package:flutter/material.dart';
import 'package:flutter_auth_vk/models/app_user.dart';
import 'package:flutter_auth_vk/services/auth_service.dart';
import 'package:flutter_auth_vk/shared/styled_button.dart';
import 'package:flutter_auth_vk/shared/styled_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);

    Future<void> handleLogout() async {
      isLoading.value = true;
      final _ = await AuthService.signOut();
      isLoading.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Your Profile'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StyledHeading('Profile'),
            const SizedBox(
              height: 16.0,
            ),

            // Output user email later
            StyledBodyText('Welcome to your profile, ${user.email}'),
            const SizedBox(
              height: 16.0,
            ),

            StyledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      handleLogout();
                    },
              child: isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const StyledButtonText('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
