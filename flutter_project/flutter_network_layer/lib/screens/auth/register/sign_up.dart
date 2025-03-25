import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/notifier/auth/register/auth_register_notifier.dart';
import 'package:flutter_network_layer/notifier/auth/register/auth_verify_notifier.dart';
import 'package:flutter_network_layer/screens/home/home_screen.dart';
import 'package:flutter_network_layer/shared/styled_button.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_network_layer/shared/styled_textfield.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:flutter_network_layer/utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final rePasswordController = useTextEditingController();
    final otpController = useTextEditingController();
    final errorFeedback = useState<String?>(null);
    final isVerify = useState<bool>(false);
    final isLoading = useState<bool>(false);
    final isVerifying = useState<bool>(false);

    return Consumer(
      builder: (context, ref, child) {
        final authRegisterState = ref.watch(authRegisterProvider);
        final authRegisterNotifier = ref.read(authRegisterProvider.notifier);
        final authVerifyState = ref.watch(authVerifyProvider);
        final authVerifyNotifier = ref.read(authVerifyProvider.notifier);

        Future<void> handleSignUp() async {
          if (!formKey.value.currentState!.validate()) return;

          if (passwordController.text.trim() !=
              rePasswordController.text.trim()) {
            errorFeedback.value = "Passwords do not match!";
            return;
          }

          errorFeedback.value = null;
          isVerify.value = false;
          isLoading.value = true;

          try {
            await authRegisterNotifier.register(
              usernameController.text.trim(),
              emailController.text.trim(),
              passwordController.text.trim(),
              rePasswordController.text.trim(),
            );
          } catch (error) {
            errorFeedback.value = error.toString();
          } finally {
            isLoading.value = false;
          }
        }

        Future<void> handleVerifyCode() async {
          if (otpController.text.length != 6) {
            errorFeedback.value = "Verification code must be 6 digits!";
            return;
          }

          isVerifying.value = true;
          try {
            await authVerifyNotifier.verify(
              emailController.text.trim(),
              otpController.text.trim(),
            );
            errorFeedback.value = "Account verified successfully!";
          } catch (error) {
            errorFeedback.value = error.toString();
          } finally {
            isVerifying.value = false;
          }
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: StyledBodyText('Create a new account.')),
                const SizedBox(height: 16.0),

                Visibility(
                  visible: !isVerify.value,
                  child: Column(
                    children: [
                      StyledTextField(
                        controller: usernameController,
                        label: 'Username',
                        validator:
                            (value) =>
                                value!.isEmpty ? "Username is required" : null,
                      ),
                      const SizedBox(height: 16),

                      StyledTextField(
                        controller: emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 16),

                      StyledTextField(
                        controller: passwordController,
                        label: 'Password',
                        obscureText: true,
                        validator: Validators.validatePassword,
                      ),
                      const SizedBox(height: 16),

                      StyledTextField(
                        controller: rePasswordController,
                        label: 'Confirm Password',
                        obscureText: true,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? "Please confirm your password"
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      if (errorFeedback.value != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            errorFeedback.value!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      StyledButton(
                        onPressed: isLoading.value ? null : handleSignUp,
                        child: StyledButtonText('Sign Up'),
                      ),
                    ],
                  ),
                ),

                authRegisterState.when(
                  data: (authResponse) {
                    if (authResponse != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        isVerify.value = true;
                      });
                    }
                    return const SizedBox.shrink();
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text("Error: ${error.toString()}"),
                ),

                Visibility(
                  visible: isVerify.value,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      StyledTextField(
                        controller: otpController,
                        label: 'Enter Verification Code',
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Verification code is required";
                          if (value.length != 6)
                            return "Verification code must be 6 digits";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      StyledButton(
                        onPressed: isVerifying.value ? null : handleVerifyCode,
                        child: StyledButtonText('Verify Code'),
                      ),
                    ],
                  ),
                ),
                authVerifyState.when(
                  data: (authResponse) {
                    if (authResponse != null) {
                      SecureStorage().writeSecureData(
                        'accessToken',
                        authResponse.accessToken,
                      );

                      SecureStorage().writeSecureData(
                        'email',
                        authResponse.user.email,
                      );

                      ref.invalidate(authRegisterProvider);

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Future.microtask(() {
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        });
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

  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  //   TextInputType keyboardType = TextInputType.text,
  //   bool obscureText = false,
  //   int? maxLength,
  //   String? Function(String?)? validator,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     keyboardType: keyboardType,
  //     obscureText: obscureText,
  //     maxLength: maxLength,
  //     decoration: InputDecoration(labelText: label),
  //     validator: validator,
  //   );
  // }
}
