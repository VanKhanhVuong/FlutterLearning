import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/notifier/auth/auth_login_notifier.dart';
import 'package:flutter_network_layer/screens/home/home_screen.dart';
import 'package:flutter_network_layer/shared/styled_button.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_network_layer/utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignIn extends HookWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final errorFeedback = useState<String?>(null);
    final isLoading = useState<bool>(false);

    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authLoginProvider);
        final authNotifier = ref.read(authLoginProvider.notifier);

        Future<void> handleSignIn() async {
          if (!formKey.value.currentState!.validate()) return;

          errorFeedback.value = null;
          isLoading.value = true;

          try {
            await authNotifier.login(
              emailController.text.trim(),
              passwordController.text.trim(),
            );
          } catch (error) {
            errorFeedback.value = error.toString();
          } finally {
            isLoading.value = false;
          }
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: StyledBodyText('Sign in to your account.')),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),

                // Hiển thị lỗi nếu có
                if (errorFeedback.value != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      errorFeedback.value!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Nút đăng nhập
                StyledButton(
                  onPressed: isLoading.value ? null : handleSignIn,
                  child: const StyledButtonText('Sign In'),
                ),

                // Xử lý trạng thái thành công
                authState.when(
                  data: (authResponse) {
                    if (authResponse != null) {
                      // Thông báo đăng nhập thành công và chuyển đến trang dashboard
                      print(
                        "SignIN Email: ${authResponse.user.email} , accessToken: ${authResponse.accessToken}",
                      );
                      SecureStorage().writeSecureData(
                        'accessToken',
                        authResponse.accessToken,
                      );

                      SecureStorage().writeSecureData(
                        'email',
                        authResponse.user.email,
                      );

                      Future.microtask(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      });
                    }
                    return const SizedBox.shrink();
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text("Error: ${error.toString()}"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
