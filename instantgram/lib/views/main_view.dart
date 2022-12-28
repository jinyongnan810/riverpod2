import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/components/dialogs/logout_dialog.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/helpers/pick_image_helper.dart';
import 'package:instantgram/providers/auth_state_provider.dart';
import 'package:instantgram/providers/post_settings_notifier_provider.dart';
import 'package:instantgram/views/new_post_view.dart';
import 'package:instantgram/views/tabs/all_posts_view.dart';
import 'package:instantgram/views/tabs/search_view.dart';
import 'package:instantgram/views/tabs/user_posts_view.dart';

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
                onPressed: () async {
                  final pickedFile =
                      await PickImageHelper.pickVideoFromGallery();
                  if (pickedFile == null) {
                    return;
                  }
                  final _ = ref.refresh(postSettingsNotifierProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewPostView(
                        fileToUpload: pickedFile,
                        fileType: FileType.video,
                      ),
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.film)),
            IconButton(
                onPressed: () async {
                  final pickedFile =
                      await PickImageHelper.pickImageFromGallery();
                  if (pickedFile == null) {
                    return;
                  }
                  final _ = ref.refresh(postSettingsNotifierProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewPostView(
                        fileToUpload: pickedFile,
                        fileType: FileType.image,
                      ),
                    ),
                  );
                },
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
          bottom: const TabBar(tabs: [
            Icon(Icons.person),
            Icon(Icons.search),
            Icon(Icons.home),
          ]),
        ),
        body: const TabBarView(children: [
          UserPostsView(),
          SearchView(),
          AllPostsView(),
        ]),
      ),
    );
  }
}
