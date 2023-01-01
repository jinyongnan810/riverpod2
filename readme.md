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

# Upload image/video to Firebase Storage

### Pick image/video

```dart
class PickImageHelper {
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile();
  static Future<File?> pickVideoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
}
```

### Create thumbnail

```dart
late Uint8List thumbnailUint8List;
switch (fileType) {
  case FileType.image:
    final fileAsImage = img.decodeImage(file.readAsBytesSync());
    if (fileAsImage == null) {
      throw const CouldNotBuildThumbnailException();
    }
    final thumbnail = img.copyResize(
      fileAsImage,
      width: ThumbnailSettings.imageThumbnailWidth,
    );
    final thumbnailData = img.encodeJpg(thumbnail);
    thumbnailUint8List = Uint8List.fromList(thumbnailData);
    break;
  case FileType.video:
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      quality: ThumbnailSettings.videoThumbnailQuality,
      maxHeight: ThumbnailSettings.videoThumbnailMaxHeight,
    );
    if (thumbnail == null) {
      throw const CouldNotBuildThumbnailException();
    }
    thumbnailUint8List = thumbnail;
    break;
}
```

### Get aspect ratio

```dart
extension ImageAspect on Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();
    image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      final ratio = image.image.width / image.image.height;
      image.image.dispose();
      completer.complete(ratio);
    }));
    return completer.future;
  }
}

extension DataImageAspect on Uint8List {
  Future<double> getAspectRatio() async {
    final image = Image.memory(this);
    return image.getAspectRatio();
  }
}
```

### Upload to firestore

```dart
// get firebase storage ref
final originalRef = FirebaseStorage.instance
    .ref('$userId/${fileType.getStorageName()}/$fileName');
final thumbnailRef = FirebaseStorage.instance
    .ref('$userId/${StorageCollectionName.thumbnails}/$fileName');

final originalUploadTask = await originalRef.putFile(file);
final thumbnailUploadTask =
    await thumbnailRef.putData(thumbnailUint8List);
```

### Display with adapted aspect ratio

```dart
// for image
AspectRatio(
  aspectRatio: post.aspectRatio,
  child: Image.network(
    post.fileUrl,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return LottieAnimationView.loading();
    },
  ),
);

// for video
final controller = VideoPlayerController.network(post.fileUrl);
final videoPlayerReady = useState(false);
useEffect(() {
  controller.initialize().then((value) {
    videoPlayerReady.value = true;
    controller.setLooping(true);
    controller.play();
  });
  return controller.dispose;
}, [controller]);
if (videoPlayerReady.value) {
  return AspectRatio(
    aspectRatio: post.aspectRatio,
    child: VideoPlayer(controller),
  );
}
return LottieAnimationView.loading();
```
