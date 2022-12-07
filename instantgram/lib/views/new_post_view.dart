import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/constants/strings.dart';
import 'package:instantgram/enums/file_type.dart';
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
    );
  }
}
