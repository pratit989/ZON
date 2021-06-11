import 'dart:ui';

import 'package:dog_help_demo/Screens/NGOProfilePage.dart';
import 'package:dog_help_demo/Widgets/Drawer.dart';
import 'package:dog_help_demo/Widgets/Carousel.dart';
import 'package:dog_help_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NGOHome extends StatefulWidget {
  const NGOHome({Key? key}) : super(key: key);

  @override
  _NGOHomeState createState() => _NGOHomeState();
}

class _NGOHomeState extends State<NGOHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},
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
      drawer: MyDrawer(),
      body: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 40.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(profileURL),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Title(
                                    color: Colors.black,
                                    child: Text(
                                        authInstance.currentUser!.displayName!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20
                                        ),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: 75),
                      child: Text('Save Me', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 30),),
                    ),
                    Carousel(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.2, 60)),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20)))
                    ),
                    elevation: MaterialStateProperty.all(0)
                ),
                child: ClipRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 50.0),
                    child: IconButton(
                      icon: Icon(Icons.account_circle_rounded),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NGOProfilePage()));
                      },
                      iconSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ButtonStyle(
            //         fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.4, 60)),
            //         backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.8)),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //             RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)))
            //         ),
            //         elevation: MaterialStateProperty.all(0)
            //     ),
            //     child: ClipRect(
            //       clipBehavior: Clip.antiAliasWithSaveLayer,
            //       child: BackdropFilter(
            //         filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 50.0),
            //         child: ElevatedButton(
            //           onPressed: () {
            //             Navigator.pushNamed(context, '/Camera');
            //           },
            //           child: Text('ReHome', style: TextStyle(fontSize: 20),),
            //           style: ButtonStyle(
            //             backgroundColor: MaterialStateProperty.all(Colors.transparent),
            //             elevation: MaterialStateProperty.all(0)
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.2, 60)),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20)))
                    ),
                    elevation: MaterialStateProperty.all(0)
                ),
                child: ClipRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 50.0),
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Map');
                      },
                      iconSize: 40,
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
