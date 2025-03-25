import 'package:flutter/material.dart';
import 'package:flutter_network_layer/notifier/auth/refresh_login_notifier.dart';
import 'package:flutter_network_layer/screens/auth/forgot/forgot_password.dart';
import 'package:flutter_network_layer/screens/auth/sign_in.dart';
import 'package:flutter_network_layer/screens/auth/register/sign_up.dart';
import 'package:flutter_network_layer/screens/home/home_screen.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthScreen { signIn, signUp, forgotPassword }

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  AuthScreen currentScreen = AuthScreen.signUp;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authRefreshNotifier = ref.read(authRefreshProvider.notifier);

    String? email = await SecureStorage().readSecureData('email');
    String? accessToken = await SecureStorage().readSecureData('accessToken');

    if (accessToken.isNotEmpty) {
      await authRefreshNotifier.refreshToken(email, accessToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authRefreshState = ref.watch(authRefreshProvider);

    return authRefreshState.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) {
        return _buildLoginScreen();
      },
      data: (authResponse) {
        if (authResponse != null) {
          SecureStorage().writeSecureData(
            'accessToken',
            authResponse.accessToken,
          );
          SecureStorage().writeSecureData('email', authResponse.user.email);

          Future.microtask(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });

          return const Scaffold();
        }

        return _buildLoginScreen(); // Nếu không có authResponse, hiển thị màn hình đăng nhập
      },
    );
  }

  Widget _buildLoginScreen() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const StyledHeading('Welcome.'),

              if (currentScreen == AuthScreen.signUp)
                Column(
                  children: [
                    const SignUpScreen(),
                    const StyledBodyText('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = AuthScreen.signIn;
                        });
                      },
                      child: Text(
                        'Sign in instead',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),

              if (currentScreen == AuthScreen.signIn)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SignInScreen(),
                    const SizedBox(
                      height: 20,
                    ), // Khoảng cách giữa form và dòng chữ

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StyledBodyText("Need an account? "),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              currentScreen = AuthScreen.signUp;
                            });
                          },
                          child: Text("Sign up", style: GoogleFonts.poppins()),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StyledBodyText("Forgot Password? "),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              currentScreen = AuthScreen.forgotPassword;
                            });
                          },
                          child: Text(
                            "Reset here",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              if (currentScreen == AuthScreen.forgotPassword)
                Column(
                  children: [
                    const ForgotPasswordScreen(),
                    const StyledBodyText('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = AuthScreen.signIn;
                        });
                      },
                      child: Text(
                        'Sign in instead',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
