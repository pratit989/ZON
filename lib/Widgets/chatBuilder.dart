import 'package:flutter/material.dart';

import '../main.dart';

List<String> chats = [];

class ChatBuilder extends StatefulWidget {
  @override
  _ChatBuilderState createState() => new _ChatBuilderState();
}

class _ChatBuilderState extends State<ChatBuilder> {
  late PageController controller;
  int currentPage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.76,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
          itemCount: downloadURLs.length,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          controller: controller,
          itemBuilder: (context, index) => builder(index)
      ),
    );
  }

  builder(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page! - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 350,
            width: Curves.easeOut.transform(value) * 400,
            child: child,
          ),
        );
      },
      child:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20)
          ),
          child: Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                chats[currentPage],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}