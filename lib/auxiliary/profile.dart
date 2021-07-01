import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Chips> skills = [
    Chips(title: 'Environmentalist'),
    Chips(title: 'Conservationist'),
    Chips(title: 'Researcher'),
    Chips(title: 'Philanthropist'),
    Chips(title: 'Volunteer'),
    Chips(title: 'Sensitization'),
    Chips(title: 'Developer'),
    Chips(title: 'Community Engagement'),
  ];

  final rand = Random();
  late String userName;
  late String userEmail;
  late String userPhoto;
  late String userNumber;

  var _auth = FirebaseAuth.instance.currentUser;

  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() async {
    // TODO: implement initState
    await userColl.doc(_auth!.uid).get().then((value) {
      // Map user = value.doc().asMap();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset(
                                'assets/background/rain-3443977_640.jpg')
                            .image,
                        fit: BoxFit.cover)),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      // ignore: unnecessary_null_comparison
                      backgroundImage:
                          Image.asset('assets/images/userImage.png').image,
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'John Doe',
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.green.shade600,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                // "+25472982736451",
                "+254788833344",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'doe@example.com',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(6.0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                          onPressed: () {},
                          color: Colors.green.shade800,
//               margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),

                          elevation: 4.0,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              child: Text(
                                "Message",
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.all(6.0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                          onPressed: () {},
                          color: Colors.green.shade800,
//               margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),

                          elevation: 4.0,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              child: Text(
                                "Call",
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ))),
                    ),
                  ]),
              SizedBox(
                height: 15,
              ),
              Wrap(
                children: List<Widget>.generate(skills.length, (int index) {
                  return Container(
                    margin: EdgeInsets.all(6.0),
                    child: Chip(
                      elevation: 6.0,
                      padding: EdgeInsets.all(10.0),
                      shape: StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(
                              rand.nextInt(150),
                              rand.nextInt(255),
                              rand.nextInt(255),
                              rand.nextInt(255),
                            ),
                            style: BorderStyle.solid,
                            width: 1.2),
                      ),
                      backgroundColor: Colors.white,
                      label: Text(
                        skills[index].title,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  );
                }),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Projects",
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "15",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "2000",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Chips {
  Chips({required this.title});
  final String title;
}
