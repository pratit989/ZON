import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';

class ExtractArguments extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final PictureDisplay args = ModalRoute.of(context)!.settings.arguments as PictureDisplay;
    return Container(
      height: MediaQuery.of(context).size.height*0.1,
      width: MediaQuery.of(context).size.width*0.1,
      child: Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            title: Text(args.auth.currentUser!.displayName!),
            backgroundColor: Colors.black87,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                  Future<File> compressFile(File file) async{
                    File compressedFile = await FlutterNativeImage.compressImage(file.path,
                      quality: 50,);
                    return compressedFile;
                  }

                  if(result != null) {
                    File file = File(result.files.single.path!);
                    File compressed = await compressFile(file);
                    try {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Uploading Image')));
                      await args.storage
                          .ref('users/' + args.auth.currentUser!.uid + '/1p.jpg')
                          .putFile(compressed);
                      Navigator.pop(context);
                    } on firebase_core.FirebaseException catch (e) {
                      print(e);
                      // e.g, e.code == 'canceled'
                    }
                  } else {
                    // User canceled the picker
                  }
                }, iconSize: 35,),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    Future<File> getImageFileFromAssets(String path) async {
                      final byteData = await rootBundle.load('assets/$path');

                      final file = File('${(await getTemporaryDirectory()).path}/$path');
                      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

                      return file;
                    }
                    File defaultImg = await getImageFileFromAssets('1p.jpg');

                    try {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Deleting Image')));
                      await args.storage
                          .ref('users/' + args.auth.currentUser!.uid + '/1p.jpg')
                          .putFile(defaultImg);
                      Navigator.pop(context);
                    } on firebase_core.FirebaseException catch (e) {
                      print(e);
                      // e.g, e.code == 'canceled'
                    }
                  },
                  iconSize: 35,),
                IconButton(icon: Icon(Icons.info_outline), onPressed: () {}, iconSize: 35,),
              ],
            ),
          ),
          body: Center(child: Image.network(args.url))
      ),
    );
  }
}


class PictureDisplay {
  late final String url;
  final FirebaseAuth auth;
  final firebase_storage.FirebaseStorage storage;

  PictureDisplay(this.url, this.auth, this.storage);
}
