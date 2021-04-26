import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManagement {
  Future<File> compressFile(File file) async{
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
      quality: 25,);
    return compressedFile;
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}