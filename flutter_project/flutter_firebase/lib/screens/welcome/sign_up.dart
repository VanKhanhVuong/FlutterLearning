import 'package:flutter/material.dart';
import 'package:flutter_auth_vk/services/auth_service.dart';
import 'package:flutter_auth_vk/shared/styled_button.dart';
import 'package:flutter_auth_vk/shared/styled_text.dart';
import 'package:flutter_auth_vk/utils/validators.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
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
            const Center(child: StyledBodyText('Sign Up for a new account')),
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

            // Re-Password
            TextFormField(
              controller: _repasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Re-Password'),
              validator: (value) => Validators.validateRePassword(
                  value, _passwordController.text),
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
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  final user = await AuthService.signUp(email, password);

                  // Error Feedback
                  if (user == null) {
                    setState(() {
                      _errorFeedback =
                          "Could not sign up with those details. Please try again!";
                    });
                  }
                }
              },
              child: const StyledButtonText('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
