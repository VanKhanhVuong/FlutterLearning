import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/notifier/auth/forgot/auth_forgot_notifier.dart';
import 'package:flutter_network_layer/notifier/auth/forgot/auth_reset_notifier.dart';
import 'package:flutter_network_layer/screens/home/home_screen.dart';
import 'package:flutter_network_layer/shared/styled_button.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_network_layer/shared/styled_textfield.dart';
import 'package:flutter_network_layer/utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final otpController = useTextEditingController();
    final passwordController = useTextEditingController();
    final rePasswordController = useTextEditingController();
    final errorFeedback = useState<String?>(null);
    final isVerify = useState<bool>(false);
    final isLoading = useState<bool>(false);
    final isVerifying = useState<bool>(false);

    return Consumer(
      builder: (context, ref, child) {
        final authForgotState = ref.watch(authForgotProvider);
        final authForgotNotifier = ref.read(authForgotProvider.notifier);
        final authResetPasswordState = ref.watch(authResetPasswordProvider);
        final authResetPasswordNotifier = ref.read(
          authResetPasswordProvider.notifier,
        );

        Future<void> handleRequestResetPassword() async {
          if (!formKey.value.currentState!.validate()) return;

          errorFeedback.value = null;
          isVerify.value = false;
          isLoading.value = true;

          try {
            await authForgotNotifier.forgotPassword(
              emailController.text.trim(),
            );
          } catch (error) {
            errorFeedback.value = error.toString();
          } finally {
            isLoading.value = false;
          }
        }

        Future<void> handleResetPassword() async {
          if (otpController.text.length != 6) {
            errorFeedback.value = "Verification code must be 6 digits!";
            return;
          }

          isVerifying.value = true;
          try {
            await authResetPasswordNotifier.resetPassword(
              otpController.text.trim(),
              emailController.text.trim(),
              passwordController.text.trim(),
              rePasswordController.text.trim(),
            );
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
                        controller: emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
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
                        onPressed:
                            isLoading.value ? null : handleRequestResetPassword,
                        child: StyledButtonText('Reset Password'),
                      ),
                    ],
                  ),
                ),

                authForgotState.when(
                  data: (authResponse) {
                    if (authResponse?.success == true) {
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
                      StyledBodyText(
                        'Reset Password For ${emailController.text.toString()}',
                      ),
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

                      if (errorFeedback.value != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            errorFeedback.value!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // const SizedBox(height: 16),
                      StyledButton(
                        onPressed:
                            isVerifying.value ? null : handleResetPassword,
                        child: StyledButtonText('Verify Code'),
                      ),
                    ],
                  ),
                ),
                authResetPasswordState.when(
                  data: (authResponse) {
                    if (authResponse != null) {
                      ref.invalidate(authForgotProvider);

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
}
