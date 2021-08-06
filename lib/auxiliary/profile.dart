import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takaconnect/utils/navbar1.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

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
  late bool profilePic;

  late String fileName = '';
  late File imageFile;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  var _auth = FirebaseAuth.instance.currentUser;

  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');
  late Map user;

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.orange[600];
  }

  @override
  void initState() {
    // TODO: implement initState
    profilePic = false;
    super.initState();
  }

  // add user image
  _addUserImage(String image) async {
    print('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
    await userColl.doc(_auth!.uid).update({
      'image': await storage.ref(fileName).getDownloadURL(),
      'imageName': fileName
    });
    print('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
  }

  Future<void> uploadFile() async {
    try {
      print('DDDDDDDDDDDDDDDDDDDDDDDDATA!');
      print(fileName);
      print(imageFile);
      print('DDDDDDDDDDDDDDDDDDDDDDDDATA!');
      // Uploading the selected image with some
      print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
      await firebase_storage.FirebaseStorage.instance
          .ref('images/$fileName')
          .putFile(imageFile);
      print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message.toString().toUpperCase());
    }
  }

  // Upload image to firebase
  Future upload() async {
    try {
      print('DDDDDDDDDDDDDDDDDDDDDDDDATA!');
      print(fileName);
      print(imageFile);
      print('DDDDDDDDDDDDDDDDDDDDDDDDATA!');

      // Uploading the selected image with some custom meta data
      await storage.ref(fileName).putFile(imageFile);
      print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
      storage.ref(fileName).putFile(imageFile);
      print(storage.toString());
      print(storage.ref(fileName).getDownloadURL());
      print('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
      await userColl.doc(_auth!.uid).update({
        'image': await storage.ref(fileName).getDownloadURL(),
        'imageName': fileName
      });
      print('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
      setState(() {});
      return storage
          .ref(fileName)
          .getDownloadURL()
          .then((value) => _addUserImage(value));
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  // Select and image from the gallery or take a picture with the camera
  Future<void> _select(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      setState(() {
        fileName = path.basename(pickedImage!.path);
        imageFile = File(pickedImage.path);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar1(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // automaticallyImplyLeading: false,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: userColl.doc(_auth!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> user =
                  snapshot.data!.data() as Map<String, dynamic>;
              return SingleChildScrollView(
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
                          height: 240,
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: user['image'] == ''
                                      ? Image.asset(
                                              'assets/appIcons/ic_launcher.png')
                                          .image
                                      : NetworkImage(user['image']),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        user['name'] ?? 'John Doe',
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
                        user['phone'] ?? "+254788833344",
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
                        user['role'] ?? 'Collector',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "County",
                                          style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          user['county'] ?? 'Nairobi',
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
                                          "Sub-County",
                                          style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          user['subcounty'] ?? "Lang'ata",
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
                        height: 10,
                      ),
                      Visibility(
                        visible: false,
                        // visible: !profilePic,
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() {
                            profilePic = !profilePic;
                          }),
                          icon: Icon(Icons.person),
                          label: Text('Display Image'),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        // visible: profilePic,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () => _select('camera'),
                                    icon: Icon(Icons.camera),
                                    label: Text('camera')),
                                ElevatedButton.icon(
                                    onPressed: () => _select('gallery'),
                                    icon: Icon(Icons.library_add),
                                    label: Text('Gallery')),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text('File:'),
                                    Flexible(
                                      child: Text(fileName,
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            print('OOOOOOOOOOOOOOOOOOOOOOOOO');
                                            uploadFile();
                                            print('OOOOOOOOOOOOOOOOOOOOOOOOO');
                                          },
                                          child: Text('Upload')),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            profilePic = !profilePic;
                                          });
                                        },
                                        child: Text('Cancel'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(getColor)),
                                      )
                                    ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child:
                      //  CircularProgressIndicator(),
                      FlareActor(
                    'assets/loading.flr',
                    animation: 'loading',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class Chips {
  Chips({required this.title});
  final String title;
}
