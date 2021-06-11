import 'dart:io';

import 'package:dog_help_demo/Backend/FileManager.dart';
import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ExtractArguments extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final PictureDisplay args =
        ModalRoute.of(context)!.settings.arguments as PictureDisplay;
    final FileManagement fileManager = FileManagement();
    final FirebaseStorageManager storageManager = FirebaseStorageManager();
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.1,
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
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      File compressedFile =
                          await fileManager.compressFile(file);
                      try {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Uploading Image')));
                        storageManager.uploadFile(
                            profilePictureReferenceURL,
                            compressedFile);
                        profileURL = await storageManager
                            .getDownloadURL(profilePictureReferenceURL);
                        Navigator.pop(context);
                      } on FirebaseException catch (e) {
                        print(e);
                        // e.g, e.code == 'canceled'
                      }
                    } else {
                      // User canceled the picker
                    }
                  },
                  iconSize: 35,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Deleting Image')));
                    await storageManager.resetProfilePicture();
                    profileURL = await storageManager
                        .getDownloadURL(profilePictureReferenceURL);
                    Navigator.pop(context);
                  },
                  iconSize: 35,
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(context, '/ProfilePage');
                  },
                  iconSize: 35,
                ),
              ],
            ),
          ),
          body: Center(child: Image.network(profileURL))),
    );
  }
}

class PictureDisplay {
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  PictureDisplay(
      {required this.auth, required this.storage});
}
