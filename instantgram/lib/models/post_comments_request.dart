import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instantgram/enums/sorting_method.dart';
import 'package:instantgram/typedefs/post_id.dart';
part 'post_comments_request.freezed.dart';

@freezed
abstract class PostCommentsRequest with _$PostCommentsRequest {
  const factory PostCommentsRequest({
    required PostId postId,
    required int? limit,
    required bool orderByCreatedAt,
    required SortingMethod sortingMethod,
  }) = _PostCommentsRequest;
}
