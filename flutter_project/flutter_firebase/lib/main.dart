import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth_vk/models/app_user.dart';
import 'package:flutter_auth_vk/providers/auth_provider.dart';
// import 'package:flutter_auth_vk/screens/profile/profile.dart';
import 'package:flutter_auth_vk/screens/todo/todo_screen.dart';
import 'package:flutter_auth_vk/screens/welcome/welcome.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: Consumer(builder: (context, ref, child) {
          final AsyncValue<AppUser?> user = ref.watch(authProvider);
          return user.when(
            data: (value) {
              if (value == null) {
                return const WelcomeScreen();
              }
              // return ProfileScreen(user: value);
              return const TodoListScreen();
            },
            error: (error, _) => const Text('Error loading auth status...'),
            loading: () => const Text('Loading...'),
          );
        }));
  }
}
