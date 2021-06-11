import 'package:dog_help_demo/Screens/Camera.dart';
import 'package:dog_help_demo/Widgets/NgoHomeCarousel.dart';
import 'package:dog_help_demo/main.dart';
import 'package:flutter/material.dart';

Map<String, String> adoptionData = {};

class AnimalAdoptionAdvertise extends StatefulWidget {
  @override
  _ViewHelpState createState() => _ViewHelpState();
}

class _ViewHelpState extends State<AnimalAdoptionAdvertise> {

  late double dataBoxWidth = MediaQuery.of(context).size.width*0.18;
  late double dataBoxHeight = dataBoxWidth;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                child: Image.asset(adoptionData['imagePath']??''),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(adoptionData['Name'] ?? "N/A",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context).size.height*0.04,
                                              fontWeight: FontWeight.w900
                                          ),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width/1.4,
                                    ),
                                    Container(
                                      child: Text(adoptionData['Location'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width/1.4,
                                    )
                                  ],
                                ),
                              ],
                            ),
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
                                    color: Colors.amber
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Age',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.height*0.020,
                                      ),
                                    ),
                                    Text(
                                        adoptionData['Age'] ?? 'N/A',
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
                                    color: Colors.amber
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Weight',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.height*0.020,
                                      ),
                                    ),
                                    Text(
                                      adoptionData['Weight'] ?? 'N/A',
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
                                    color: Colors.amber
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Sex',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.height*0.020,
                                      ),
                                    ),
                                    Text(
                                      adoptionData['Sex'] ?? 'N/A',
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
                                    color: Colors.amber
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Color',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.height*0.020,
                                      ),
                                    ),
                                    Text(
                                      adoptionData['Color'] ?? 'N/A',
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
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(adoptionData['ngoImagePath']??''),
                                      radius: MediaQuery.of(context).size.width*0.06,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: Text(
                                          adoptionData['NGO'] ?? "N/A",
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
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text('Adopt', style: TextStyle(color: Colors.black, fontSize: 20),),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.amber)
                                    ),
                                ),
                              )
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}