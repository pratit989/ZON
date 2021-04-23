import 'package:dog_help_demo/Screens/ProfilePicture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class Home extends StatefulWidget {
  final List<String> list = ['Healing Hearts', 'Woof Project Rescue', 'Applied Animal', 'Small Paws'];
  final FirebaseAuth authInstance;
  final firebase_storage.FirebaseStorage storageInstance;

  Home({
    required this.authInstance, required this.storageInstance,
  });
  @override
  _DogHelpState createState() => _DogHelpState();
}

class _DogHelpState extends State<Home> {
  late String profileURL;
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeProfile() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      print('users/' + widget.authInstance.currentUser!.uid + '/1p.jpg');
      profileURL =  await widget.storageInstance
          .ref('users/' + widget.authInstance.currentUser!.uid + '/1p.jpg')
          .getDownloadURL();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void fun() {
      setState(() {});
    }
    fun();
    // Show error message if initialization failed
    if(_error) {
      return Text('Something went wrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height*0.04,
                vertical: MediaQuery.of(context).size.height*0.1
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          print('tapped');
                          await Navigator.pushNamed(
                              context,
                              ExtractArguments.routeName,
                              arguments:PictureDisplay(
                                  profileURL,
                                  widget.authInstance,
                                  widget.storageInstance,
                              )
                          );
                          initializeProfile();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: NetworkImage(profileURL),
                          key: UniqueKey(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.authInstance.currentUser!.displayName!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(context).size.width*0.08,
                              ),
                            ),
                            Text(
                              'Saviour',
                              style: TextStyle(
                                  color: Colors.red[300],
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: 'home',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'save a dog',
                          onPressed: () {
                            Navigator.pushNamed(context, '/Camera');
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Save a Dog',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'add NGO',
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.add_business,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Add a new NGO',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'Messages',
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Messages',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'profile',
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Profile',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.26,
                  ),
                  Row(
                    children: [
                      FloatingActionButton.extended(
                        heroTag: 'settings',
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                      Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      FloatingActionButton.extended(
                          onPressed: () async {
                            await widget.authInstance.signOut();
                            Navigator.pushReplacementNamed(context, '/Login');
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          icon: null,
                          label: Text(
                            'Log Out',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              iconSize: MediaQuery.of(context).size.height * 0.06,
              color: Colors.black,
              icon: Icon(
                Icons.menu_rounded,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: Stack(
                            children: [
                              ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                buttonColor: Colors.transparent,
                                child: OutlineButton(
                                  borderSide: BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  onPressed: () {
                                    showSearch(
                                      context: context,
                                      delegate: Search(widget.list),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Search NGO's",
                                        style: TextStyle(
                                          color: Colors.grey
                                        ),
                                      ),
                                      Icon(Icons.search)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 70,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 17,
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
                                        fontSize: MediaQuery.of(context).size.width * 0.1,
                                      ),
                                    ),
                                    Text(
                                      'Each new day, A new life saved!!',
                                      style: TextStyle(
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 34,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context, '/DogProfile');
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: Image(
                                                      image: AssetImage('assets/1.jpg'),
                                                    )
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 1',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/2.jpg'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 2',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/3.jpg'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 3',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/4.jpg'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 4',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
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
                            Expanded(
                              flex: 10,
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Top NGOs",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                    fontSize: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 34,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/1n.jpg'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 1',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/2n.jpg'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 2',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/3n.png'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 3',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              margin: EdgeInsets.all(10),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image(
                                                    image: AssetImage('assets/4n.jpg'),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Dog 4',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
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
                    ),
                    Expanded(
                      flex: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black87,
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.red[400],
                                    size: MediaQuery.of(context).size.width * 0.15,
                                  ),
                                  label: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Text(
                                          'Join today & Save lives',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context).size.width * 0.045,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Text(
                                          'It only takes one tap. Take a picture and become a hero. '
                                              'Send a call for help now to your nearest NGO',
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.grey[300],
                                            fontWeight: FontWeight.w300,
                                            fontSize:  MediaQuery.of(context).size.height * 0.015,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Donate now',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: MediaQuery.of(context).size.height * 0.02
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: MediaQuery.of(context).size.height * 0.02,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}, iconSize: 35,),
            IconButton(icon: Icon(Icons.camera), onPressed: () {Navigator.pushNamed(context, '/Camera');}, iconSize: 35,),
            IconButton(icon: Icon(Icons.person), onPressed: () {}, iconSize: 35,),
          ],
        ),
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

  List<String> recentList = ['Healing Hearts', 'Woof Project Rescue', 'Applied Animal', 'Small Paws'];

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
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}