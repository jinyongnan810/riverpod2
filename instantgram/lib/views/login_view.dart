import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/divider_with_margin.dart';
import 'package:instantgram/components/google_button.dart';
import 'package:instantgram/components/login_view_signup_links.dart';
import 'package:instantgram/constants/app_colors.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/providers/auth_state_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateProvider.notifier);
    final welcome = Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text(
        Strings.welcome,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
    const loginInstructions = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(Strings.loginInstructions),
    );
    final loginWithGoogle = TextButton(
      onPressed: authStateNotifier.loginWithGoogle,
      style: TextButton.styleFrom(
          backgroundColor: AppColors.loginButtonColor,
          foregroundColor: AppColors.loginButtonTextColor,
          minimumSize: const Size(double.infinity, 44)),
      child: const GoogleButton(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcome,
              const DividerWithMargin(),
              loginInstructions,
              loginWithGoogle,
              const DividerWithMargin(),
              const LoginViewSignupLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
