import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/notifiers/delete_post_notifier.dart';
import 'package:instantgram/typedefs/is_loading.dart';

final deletePostNotifierProvider =
    StateNotifierProvider<DeletePostNotifier, IsLoading>(
        (ref) => DeletePostNotifier());
