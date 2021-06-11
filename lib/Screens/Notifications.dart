import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Notifications extends StatefulWidget {

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late List<Map<String,dynamic>> items = [];

  bool initialized = false;

  getNotificationsData() async{
    // Get data of all the Case Acceptance Notifications
    caseNotificationsData = (await firestoreManager.readDocFromCollection(
        notifications, '/caseNotifications'))![authInstance.currentUser!.uid] as Map<String, dynamic>;

    setState(() {
      if (caseNotificationsData != null) {
        for (Map<String, dynamic> value in caseNotificationsData!.values) {
          items.add(value);
        }
      }
      initialized = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotificationsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {return Center(child: CircularProgressIndicator(backgroundColor: Colors.black, color: Colors.amber,));}
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(50, MediaQuery.of(context).size.width),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 50.0,
            left: 15,
            right: 30
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
              Card(
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(profileURL),
                ),
                elevation: 16,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0,
                      ),
                      child: Text(
                          "Notifications",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 90
                      ),
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
                  clipBehavior: Clip.antiAlias,
                  elevation: 20,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: items.length,
                      padding: EdgeInsets.only(top: 20, left: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(items[index]['imageData']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                              items[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'by ${items[index]['from']} NGO',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
