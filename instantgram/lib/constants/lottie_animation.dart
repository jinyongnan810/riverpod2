enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  error(name: 'error'),
  loading(name: 'loading'),
  smallError(name: 'small_error');

  final String name;
  const LottieAnimation({required this.name});
}

extension GetFullPath on LottieAnimation {
  String fullPath() => 'assets/animations/$name.json';
}
