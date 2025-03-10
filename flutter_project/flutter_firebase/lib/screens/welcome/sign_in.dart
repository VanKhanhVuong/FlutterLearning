import 'package:flutter/material.dart';
import 'package:flutter_auth_vk/services/auth_service.dart';
import 'package:flutter_auth_vk/shared/styled_button.dart';
import 'package:flutter_auth_vk/shared/styled_text.dart';
import 'package:flutter_auth_vk/utils/validators.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Intro Text
            const Center(child: StyledBodyText('Sign in to your account.')),
            const SizedBox(height: 16.0),

            // Email address
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => Validators.validateEmail(value),
            ),
            const SizedBox(
              height: 16,
            ),

            // Password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) => Validators.validatePassword(value),
            ),
            const SizedBox(
              height: 16,
            ),

            // Error message
            if (_errorFeedback != null)
              Text(
                _errorFeedback!,
                style: const TextStyle(color: Colors.red),
              ),

            // Submit button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });

                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  final user = await AuthService.signIn(email, password);

                  // Error feedback
                  if (user == null) {
                    setState(() {
                      _errorFeedback = "Invalid login credentials";
                    });
                  }
                }
              },
              child: const StyledButtonText('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
