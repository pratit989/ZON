import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../main.dart';

late String? imagePath;

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    required this.camera,
  });

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final size = MediaQuery.of(context).size;
            final deviceRatio = size.width / size.height;
            // If the Future is complete, display the preview.
            return Transform.scale(
                scale: deviceRatio*2,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: deviceRatio,
                    child: CameraPreview(_controller)
                  )
                )
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator(color: Colors.amber));
          }
        },
      ),
      bottomNavigationBar: RawMaterialButton(
        shape: CircleBorder(),
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height*0.12,
        ),
        elevation: 0,
        fillColor: Colors.transparent,
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.radio_button_checked,
          size: 80,
          color: Colors.white,
        ),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and log where it's been saved.
            XFile file = await _controller.takePicture();
            imagePath = file.path;

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(File(imagePath!), fit: BoxFit.fill),
          ),
          RawMaterialButton(
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height*0.12,
            ),
            elevation: 0,
            fillColor: Colors.transparent,
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.check_circle,
              size: 70,
              color: Colors.white,
            ),
            // Provide an onPressed callback.
            onPressed: () async {
              if (location == null) {
                Navigator.pushReplacementNamed(context, '/Map');
              } else {
                await Navigator.pushReplacementNamed(context, '/SubmitAnimalProfile');
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
