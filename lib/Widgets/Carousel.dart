import 'dart:developer';

import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:flutter/material.dart';

import '../main.dart';

String? description;
Map<String, dynamic>? caseData;

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => new _CarouselState();
}

class _CarouselState extends State<Carousel> {
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
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(downloadURLs[index])
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          children:[
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () async {
                    Map<String, dynamic> references = await firestoreManager.readDocFromCollection(rescue, 'list') as Map<String, dynamic>;
                    for (String key in references.keys) {
                      var currentCase = downloadURLs[index].replaceFirst('%2F', '/');
                      log(currentCase);
                      if (currentCase.contains(key)) {
                        imagePath = key;
                        break;
                      }
                    }

                    caseData = await firestoreManager.readDocFromCollection(rescue, imagePath!.replaceFirst('rescue/', ''));
                    description = caseData!['Name'] ?? '';
                    location = caseData!['Address'] ?? '';
                    imagePath = downloadURLs[index];
                    Navigator.pushNamed(context, '/ViewAnimalProfile');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.done, color: Colors.black,),
                    Text('Accept', style: TextStyle(color: Colors.black),),
                  ],
                ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width * 0.8/3)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}