import 'package:flutter/material.dart';
import 'package:flutter_network_layer/notifier/auth/refresh_login_notifier.dart';
import 'package:flutter_network_layer/screens/auth/sign_in.dart';
import 'package:flutter_network_layer/screens/auth/sign_up.dart';
import 'package:flutter_network_layer/screens/home/home_screen.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_network_layer/utils/secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool isSignUpForm = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authRefreshNotifier = ref.read(authRefreshProvider.notifier);

    String? email = await SecureStorage().readSecureData('email');
    String? accessToken = await SecureStorage().readSecureData('accessToken');
    print("Welcome_Screen : Email: $email , accessToken: $accessToken");
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

              if (isSignUpForm)
                Column(
                  children: [
                    const SignUp(),
                    const StyledBodyText('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSignUpForm = false;
                        });
                      },
                      child: Text(
                        'Sign in instead',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),

              if (!isSignUpForm)
                Column(
                  children: [
                    const SignIn(),
                    const StyledBodyText('Need an account?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSignUpForm = true;
                        });
                      },
                      child: Text(
                        'Sign up instead',
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
