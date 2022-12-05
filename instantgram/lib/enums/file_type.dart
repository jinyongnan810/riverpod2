enum FileType {
  image,
  video,
}

extension StorageName on FileType {
  String getStorageName() {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}
