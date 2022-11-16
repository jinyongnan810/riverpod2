extension RemoveAll on String {
  String removeAll(Iterable<String> targets) => targets.fold(
      this, (previousValue, target) => previousValue.replaceAll(target, ''));
}
