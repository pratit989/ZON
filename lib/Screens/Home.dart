import 'dart:ui';

import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/Widgets/Drawer.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Home extends StatefulWidget {

  @override
  _DogHelpState createState() => _DogHelpState();
}

class _DogHelpState extends State<Home> {

  late String pastURL = '';

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to get Download URL for Profile Picture
  void initializeProfile() async {
    try {
      pastURL = profileURL;
      Map<String,dynamic>? urlData = await firestoreManager.readDocFromCollection(rescue, 'list');
      if (urlData != null) {
        if (carousalReferenceUrlList.isNotEmpty) {
          for (int i = 0; i < carousalReferenceUrlList.length; i++) {
            try {
              urlData.remove(carousalReferenceUrlList[i]);
            } catch (ignore) {}
          }
        }
        firestoreManager.getKeysFromMap(urlData, carousalReferenceUrlList);
        if (carousalReferenceUrlList.isNotEmpty) {
          for (int i = 0; i < carousalReferenceUrlList.length; i++) {
            downloadURLs.add(await storageManager.getDownloadURL(carousalReferenceUrlList[i]));
          }
        }
      }
      location = null;
      imagePath = null;
      if (firestoreUserData!['user_type'].toString() == 'NGO') {
        Navigator.pushReplacementNamed(context, '/NGOHome');
      }
      firestoreManager.getNgoSearchList();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  // PageView Controller
  var controller = PageController(viewportFraction: 1);

  @override
  void initState() {
    initializeProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pastURL != profileURL) {
      setState(() {});
      initializeProfile();
      return Center(child: CircularProgressIndicator(color: Colors.amber));
    }
    // Show error message if initialization failed
    if (_error) {
      return Text('Something went wrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator(color: Colors.amber));
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Z',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            Text(
              'O',
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              'N',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ],
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              iconSize: MediaQuery.of(context).size.height * 0.04,
              color: Colors.black,
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(ngoNamesList),
                );
              },
              tooltip: 'Open Search',
            );
          })
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              iconSize: MediaQuery.of(context).size.height * 0.04,
              color: Colors.black,
              icon: Icon(
                Icons.menu_rounded,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Open Drawer',
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(253, 201, 11, 1.0),
              // gradient: LinearGradient(colors: [Colors.amber, Colors.white],begin: Alignment.topCenter, end: Alignment.bottomCenter),
              boxShadow: [
                const BoxShadow(
                  color: Colors.grey,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 2),
                  spreadRadius: -2.0,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: PageView(
                        children: [
                          uerCarousal
                        ],
                      ),
                    ),
                  ),
                  // Social Interaction Box
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 15,
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Newest Pets',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.1,
                                  ),
                                ),
                                Text(
                                  'Each new day, A new life saved!!',
                                  style: TextStyle(
                                      color: Colors.black,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 34,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: PageView(
                              controller: controller,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/ViewAnimalProfile');
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20),
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/1.jpg'),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 1',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/2.jpg'),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 2',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/3.jpg'),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 3',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/4.jpg'),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 4',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              "Top NGOs",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 34,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.25,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/1n.jpg'),
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 1',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/2n.jpg'),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 2',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/3n.png'),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 3',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/4n.jpg'),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Dog 4',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(30, 30, 30, 1),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04),
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.red[400],
                                  size: MediaQuery.of(context).size.width *
                                      0.15,
                                ),
                                label: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      child: Text(
                                        'Donate today & Save lives',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0427,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      child: Text(
                                        'Every donation counts. Make a small donation to a noble cause today. '
                                        'Donate to your favourite NGO',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[300],
                                          fontWeight: FontWeight.w300,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.016,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Donate now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.02),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 60)),
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)))
                      ),
                      elevation: MaterialStateProperty.all(0)
                  ),
                  child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.circle_notifications),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Notifications');
                            },
                            iconSize: 40,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () async {
                              await Navigator.pushNamed(context, '/Camera');
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (BuildContext context) => this.widget));
                            },
                            iconSize: 40,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.location_on),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Map');
                            },
                            iconSize: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;

  Search(this.listExample);

  List<String> recentList = [
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}