# Learning From

- https://www.youtube.com/watch?v=vtGCteFYs4M

# Create Global Loading State

### 1. Use `StateNotifier` that contains loading state to make async calls

```dart
typedef IsLoading = bool;
class ApiCallsNotifier extends StateNotifier<IsLoading> {
  ApiCallsNotifier() : super(false);
  set isLoading(IsLoading loading) => state = loading;
  Future<bool> apiCalls(
      {required Params params}) async {
    isLoading = true;
    try {
      // some async calls
      return true;
    } catch (e) {
      debugPrint('Error when calling api: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }
}
```

### 2. Use `StateNotifierProvider` to warp notifier above

```dart
final apiCallsNotifierProvider = StateNotifierProvider<ApiCallsNotifier, IsLoading>(
  (ref) => ApiCallsNotifier(),
);
```

### 3. Combine all the loading state with simple `Provider`

```dart
final isLoadingProvider = Provider<IsLoading>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final uploadingState = ref.watch(uploadNotifierProvider);
    final deletingState = ref.watch(deletePostNotifierProvider);
    final commentsState = ref.watch(commentsNotifierProvider);
    final likeState = ref.watch(likesNotifierProvider);
    final isLoading = [
      authState.isLoading,
      uploadingState,
      deletingState,
      commentsState,
      likeState
    ].any((loading) => loading);
    return isLoading;
  },
);
```

### 4. Create loading dialog with Overlay

https://github.com/jinyongnan810/riverpod2/tree/main/instantgram/lib/loading

### 5. Listen to isLoadingProvider and display dialog

```dart
MaterialApp(
  title: 'instantgram',
  themeMode: ThemeMode.dark,
  darkTheme: ThemeData.dark(),
  home: Consumer(
    builder: (ctx, ref, child) {
      ref.listen(isLoadingProvider, (previous, next) {
        if (previous != null && next) {
          LoadingScreen.instance()
              .show(context: ctx, text: Strings.loading);
        } else if (previous == true && next == false) {
          LoadingScreen.instance().hide();
        }
      });
      final isLoggedIn = ref.watch(isLoggedInProvider);
      if (isLoggedIn) {
        return const MainView();
      }
      return const LoginView();
    },
  ),
);
```
