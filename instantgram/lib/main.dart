import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instantgram/auth/authenticator.dart';

import 'extensions/log.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('instantgram')),
      body: Center(
          child: TextButton(
        child: const Text('Google Login'),
        onPressed: () async {
          final result = await Authenticator().loginWithGoogle();
          result.log();
        },
      )),
    );
  }
}
