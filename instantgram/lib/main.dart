import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/login_view_signup_links.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/loading/loading_screen.dart';
import 'package:instantgram/providers/auth_state_provider.dart';
import 'package:instantgram/providers/is_loading_provider.dart';
import 'package:instantgram/providers/is_logged_in_provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'instantgram',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: Consumer(
        builder: (ctx, ref, child) {
          ref.listen(isLoadingProvider, (previous, next) {
            if (previous != null && next) {
              LoadingScreen.instance()
                  .show(context: ctx, text: Strings.loading);
            } else if (previous == true && next == false) {
              LoadingScreen.instance().hide();
            }
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('instantgram'),
          actions: [
            Consumer(builder: ((context, ref, child) {
              return IconButton(
                  onPressed: () {
                    ref.read(authStateProvider.notifier).logout();
                  },
                  icon: const Icon(Icons.logout));
            }))
          ],
        ),
        body: const Center(
          child: Text('Main Page'),
        ));
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('instantgram')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Consumer(
            builder: (_, ref, child) {
              return TextButton(
                child: const Text('Google Login'),
                onPressed: () async {
                  await ref.read(authStateProvider.notifier).loginWithGoogle();
                },
              );
            },
          )),
          const LoginViewSignupLinks(),
        ],
      ),
    );
  }
}
