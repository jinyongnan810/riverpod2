import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/helpers/pick_image_helper.dart';
import 'package:instantgram/providers/post_settings_notifier_provider.dart';
import 'package:instantgram/views/new_post_view.dart';

class PickFileBottomSheet extends ConsumerStatefulWidget {
  const PickFileBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PickFileBottomSheetState();
}

class _PickFileBottomSheetState extends ConsumerState<PickFileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text('Pick image from gallery'),
            onTap: () async {
              final pickedFile = await PickImageHelper.pickImageFromGallery();
              if (pickedFile == null) {
                return;
              }
              if (!mounted) {
                return;
              }
              Navigator.of(context).pop();
              final _ = ref.refresh(postSettingsNotifierProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPostView(
                    fileToUpload: pickedFile,
                    fileType: FileType.image,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Pick video from gallery'),
            onTap: () async {
              final pickedFile = await PickImageHelper.pickVideoFromGallery();
              if (pickedFile == null) {
                return;
              }
              if (!mounted) {
                return;
              }
              Navigator.of(context).pop();
              final _ = ref.refresh(postSettingsNotifierProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPostView(
                    fileToUpload: pickedFile,
                    fileType: FileType.video,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
