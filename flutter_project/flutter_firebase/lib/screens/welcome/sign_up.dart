import 'package:flutter/material.dart';
import 'package:flutter_auth_vk/services/auth_service.dart';
import 'package:flutter_auth_vk/shared/styled_button.dart';
import 'package:flutter_auth_vk/shared/styled_text.dart';
import 'package:flutter_auth_vk/utils/validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpForm extends HookWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final repasswordController = useTextEditingController();
    final errorFeedback = useState<String?>(null);
    final isLoading = useState<bool>(false);

    Future<void> handleSignUp() async {
      if (formKey.value.currentState!.validate()) {
        errorFeedback.value = null;
        isLoading.value = true;

        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final user = await AuthService.signUp(email, password);

        isLoading.value = false;
        if (user == null) {
          errorFeedback.value =
              "Could not sign up with those details. Please try again!";
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Intro Text
            const Center(child: StyledBodyText('Sign Up for a new account')),
            const SizedBox(height: 16.0),

            // Email address
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => Validators.validateEmail(value),
            ),
            const SizedBox(
              height: 16,
            ),

            // Password
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) => Validators.validatePassword(value),
            ),
            const SizedBox(
              height: 16,
            ),

            // Re-Password
            TextFormField(
              controller: repasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Re-Password'),
              validator: (value) =>
                  Validators.validateRePassword(value, passwordController.text),
            ),
            const SizedBox(
              height: 16,
            ),

            // Error message
            if (errorFeedback.value != null)
              Text(
                errorFeedback.value!,
                style: const TextStyle(color: Colors.red),
              ),

            // Submit button
            StyledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      handleSignUp();
                    },
              child: isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const StyledButtonText('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
