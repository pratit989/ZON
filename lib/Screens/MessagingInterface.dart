import 'package:flutter/material.dart';

class MessagingInterface extends StatefulWidget {
  const MessagingInterface({Key? key}) : super(key: key);

  @override
  _MessagingInterfaceState createState() => _MessagingInterfaceState();
}

class _MessagingInterfaceState extends State<MessagingInterface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(),
          Container(),
        ],
      ),
    );
  }
}
