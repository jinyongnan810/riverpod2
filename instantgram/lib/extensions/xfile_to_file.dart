import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension XFileToFile on Future<XFile?> {
  Future<File?> toFile() =>
      then((xFile) => xFile == null ? null : File(xFile.path));
}
