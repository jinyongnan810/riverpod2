import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/file_thumbnail_view.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/enums/file_type.dart';
import 'package:instantgram/enums/post_settings.dart';
import 'package:instantgram/models/thumbnail_request.dart';
import 'package:instantgram/providers/post_settings_notifier_provider.dart';
import 'package:instantgram/providers/upload_notifier_provider.dart';
import 'package:instantgram/providers/user_id_provider.dart';

class NewPostView extends StatefulHookConsumerWidget {
  final File fileToUpload;
  final FileType fileType;
  const NewPostView({
    super.key,
    required this.fileToUpload,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPostViewState();
}

class _NewPostViewState extends ConsumerState<NewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToUpload,
      fileType: widget.fileType,
    );
    final postSettings = ref.watch(postSettingsNotifierProvider);
    final textController = useTextEditingController();
    final publishButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          publishButtonEnabled.value = textController.text.isNotEmpty;
        }

        textController.addListener(listener);
        return () {
          textController.removeListener(listener);
        };
      },
      [textController],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            onPressed: publishButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final uploadNotifier =
                        ref.read(uploadNotifierProvider.notifier);
                    final success = await uploadNotifier.upload(
                      file: widget.fileToUpload,
                      fileType: widget.fileType,
                      userId: userId,
                      message: textController.text,
                      postSettings: postSettings,
                    );
                    if (success && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FileThumbnailView(thumbnailRequest: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: Strings.pleaseDescribeYourPost),
                autofocus: true,
                maxLines: null,
                controller: textController,
              ),
            ),
            ...PostSettings.values.map((postSetting) => ListTile(
                  title: Text(postSetting.title),
                  subtitle: Text(postSetting.description),
                  trailing: Switch(
                    value: postSettings[postSetting] ?? false,
                    onChanged: (isOn) {
                      ref
                          .read(postSettingsNotifierProvider.notifier)
                          .setSetting(postSetting, isOn);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
