import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/components/dialogs/logout_dialog.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/providers/auth_state_provider.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
                onPressed: () async {},
                icon: const FaIcon(FontAwesomeIcons.film)),
            IconButton(
                onPressed: () async {},
                icon: const Icon(Icons.add_a_photo_outlined)),
            IconButton(
              onPressed: () async {
                const dialog = LogoutDialog();
                final choice = await dialog.present(context);
                if (choice == true) {
                  ref.read(authStateProvider.notifier).logout();
                }
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
