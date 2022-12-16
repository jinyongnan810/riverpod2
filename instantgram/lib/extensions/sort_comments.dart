import 'package:instantgram/enums/sorting_method.dart';
import 'package:instantgram/models/comment.dart';

extension SortComments on Iterable<Comment> {
  Iterable<Comment> sortBy(bool needSort, SortingMethod method) {
    if (!needSort) {
      return this;
    }
    switch (method) {
      case SortingMethod.fromNewest:
        return toList()..sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
      case SortingMethod.fromOldest:
        return toList()..sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
    }
  }
}
