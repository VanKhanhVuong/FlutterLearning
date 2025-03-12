import 'package:flutter/material.dart';
import 'package:flutter_auth_vk/services/auth_service.dart';
import 'package:flutter_auth_vk/shared/styled_button.dart';
import 'package:flutter_auth_vk/shared/styled_text.dart';
import 'package:flutter_auth_vk/utils/validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignInForm extends HookWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final errorFeedback = useState<String?>(null);
    final isLoading = useState<bool>(false);

    Future<void> handleSignIn() async {
      if (formKey.value.currentState!.validate()) {
        errorFeedback.value = null;
        isLoading.value = true;

        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final user = await AuthService.signIn(email, password);

        isLoading.value = false;
        if (user == null) {
          errorFeedback.value = "Invalid login credentials";
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
            const Center(child: StyledBodyText('Sign in to your account.')),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => Validators.validateEmail(value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) => Validators.validatePassword(value),
            ),
            const SizedBox(height: 16),
            if (errorFeedback.value != null)
              Text(
                errorFeedback.value!,
                style: const TextStyle(color: Colors.red),
              ),
            StyledButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      handleSignIn();
                    },
              child: isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const StyledButtonText('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
