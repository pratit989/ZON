
import 'package:dog_help_demo/Backend/FirebaseStorageManager.dart';
import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/Widgets/Carousel.dart';
import 'package:dog_help_demo/main.dart';
import 'package:flutter/material.dart';


class ViewAnimalProfile extends StatefulWidget {
  @override
  _ViewHelpState createState() => _ViewHelpState();
}

class _ViewHelpState extends State<ViewAnimalProfile> {

  late double dataBoxWidth = MediaQuery.of(context).size.width*0.18;
  late double dataBoxHeight = dataBoxWidth;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                child: Image.network(imagePath!),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(description ?? "N/A",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context).size.height*0.04,
                                              fontWeight: FontWeight.w900
                                          ),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width/1.4,
                                    ),
                                    Container(
                                      child: Text(location ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width/1.4,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextButton(
                            onPressed: () async {
                              await firestoreManager.writeDocToCollection(notifications, 'caseNotifications',
                                  {
                                    caseData!['UID']: {
                                      uid.v4(): {
                                        'type' : 'Request Status',
                                        'title': 'Rescue request accepted',
                                        'text': description ?? 'N/A',
                                        'from': authInstance.currentUser!.displayName,
                                        'UID': authInstance.currentUser!.uid,
                                        'imageData': imagePath,
                                      }
                                    }
                                  });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(
                                      'Notification Sent Successfully.')));
                              Navigator.pop(context);
                              },
                            child: Text(
                              'Accept Rescue Request',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.05,
                                  color: Colors.black
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.amber)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}