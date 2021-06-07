import 'package:dog_help_demo/Widgets/Drawer.dart';
import 'package:dog_help_demo/Widgets/Carousel.dart';
import 'package:flutter/material.dart';

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
      body: Carousel(),
    );
  }
}
