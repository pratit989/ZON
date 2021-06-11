import 'package:dog_help_demo/Backend/FirestoreManager.dart';
import 'package:dog_help_demo/Widgets/chatBuilder.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MessagingInterface extends StatefulWidget {
  const MessagingInterface({Key? key}) : super(key: key);

  @override
  _MessagingInterfaceState createState() => _MessagingInterfaceState();
}

class _MessagingInterfaceState extends State<MessagingInterface> {
  final _chatKey = GlobalKey<FormState>();
  String chatMessage = '';
  String companion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            authInstance.currentUser!.displayName!,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: ClipRRect(
                      child: Container(color: Colors.white,),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber
                          ),
                          child: Form(
                            key: _chatKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child: TextFormField(
                                        initialValue: 'Type a message...',
                                        cursorColor: Colors.black,
                                        textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: Colors.black),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Type a message...';
                                          } else {
                                            chatMessage = value;
                                          }
                                          return null;
                                        },
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: RawMaterialButton(
                                      fillColor: Colors.transparent,
                                      elevation: 0,
                                      child: Icon(
                                        Icons.send,
                                        size: MediaQuery.of(context).size.width * 0.1,
                                        color: Colors.black,
                                      ),
                                      // Provide an onPressed callback.
                                      onPressed: () async {
                                        if (_chatKey.currentState!.validate()) {
                                          await firestoreManager.writeDocToCollection(chat, authInstance.currentUser!.uid + " " + companion, {chatMessage:chatMessage});
                                          chats.add(chatMessage);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
