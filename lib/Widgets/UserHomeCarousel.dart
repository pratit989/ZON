import 'package:dog_help_demo/Screens/ProfilePicture.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class UserHomeCarousel extends StatefulWidget {
  @override
  _UserHomeCarouselState createState() => new _UserHomeCarouselState();
}

class _UserHomeCarouselState extends State<UserHomeCarousel> {

  // Constants
  IconData _likeIcon = Icons.favorite_border;
  Color _color = Colors.white;

  late PageController controller;
  int currentPage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 1,
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
        allowImplicitScrolling: true,
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
            height: Curves.easeOut.transform(value) * 450,
            width: Curves.easeOut.transform(value) * 400,
            child: child,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    title: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          authInstance.currentUser!.displayName!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.black,
                    elevation: 0,
                    leading: GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(
                            context, ExtractArguments.routeName,
                            arguments: PictureDisplay(
                              auth: authInstance,
                              storage: storageInstance,
                            ));
                        setState(() {
                          Navigator.pushReplacementNamed(context, '/Home');
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(profileURL),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8.0, right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: NetworkImage(downloadURLs[index]),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_color == Colors.white) {
                                _likeIcon = Icons.favorite;
                                _color = Colors.red;
                              } else {
                                _likeIcon =
                                    Icons.favorite_outline;
                                _color = Colors.white;
                              }
                            });
                          },
                          icon: Icon(
                            _likeIcon,
                            color: _color,
                          ),
                        ),
                        behavior: HitTestBehavior.translucent,
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.mode_comment_outlined, color: Colors.white,),
                      // ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.send, color: Colors.white,),
                      // ),
                    ],
                  ),
                ),
              )))
    );
  }
}