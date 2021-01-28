import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DogProfile extends StatefulWidget {
  @override
  _DogHelpState createState() => _DogHelpState();
}

class _DogHelpState extends State<DogProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: Image.asset('assets/1.jpg'),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.02,
                    ),
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.55,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                      color: Colors.white
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width*0.05
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dog 1',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context).size.height*0.06,
                                          fontWeight: FontWeight.w900
                                        ),
                                      ),
                                      Text(
                                        'Chembur, Mumbai - 400071',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    iconSize: MediaQuery.of(context).size.width*0.12,
                                    icon: Icon(
                                      Icons.assignment_ind,
                                      color: Colors.red[400],
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.12),
                              margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.03),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[300]
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                            color: Colors.pink[300],
                                            fontSize: MediaQuery.of(context).size.height*0.020,
                                          ),
                                        ),
                                        Text(
                                          '1.5',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height*0.015,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[300]
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Weight',
                                          style: TextStyle(
                                            color: Colors.pink[300],
                                            fontSize: MediaQuery.of(context).size.height*0.020,
                                          ),
                                        ),
                                        Text(
                                          '18kg',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height*0.015,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[300]
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Sex',
                                          style: TextStyle(
                                            color: Colors.pink[300],
                                            fontSize: MediaQuery.of(context).size.height*0.020,
                                          ),
                                        ),
                                        Text(
                                          'Male',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height*0.015,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.020),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[300]
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Color',
                                          style: TextStyle(
                                            color: Colors.pink[300],
                                            fontSize: MediaQuery.of(context).size.height*0.020,
                                          ),
                                        ),
                                        Text(
                                          'Black',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height*0.015,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 70,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                                  color: Colors.black87
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('assets/1p.jpg'),
                                            radius: MediaQuery.of(context).size.width*0.06,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hero',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: MediaQuery.of(context).size.width*0.06,
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
                                        Container(
                                          margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('assets/1n.jpg'),
                                            radius: MediaQuery.of(context).size.width*0.06,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(
                                                'Healing Hearts',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: MediaQuery.of(context).size.width*0.06,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Foundation',
                                              style: TextStyle(
                                                  color: Colors.red[300],
                                                  fontWeight: FontWeight.w300
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.red[300]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Donate Now!',
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(context).size.width*0.05,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}