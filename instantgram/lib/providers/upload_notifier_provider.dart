import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/notifiers/upload_notifier.dart';
import 'package:instantgram/typedefs/is_loading.dart';

final uploadNotifierProvider =
    StateNotifierProvider<UploadNotifier, IsLoading>((ref) => UploadNotifier());
