import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takaconnect/auth/counties.dart';
import 'package:takaconnect/modules/categoryHome.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignupPage extends StatefulWidget {
  SignupPage(this.state);
  final String state;
  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  late bool verifyLoading = false;
  final CollectionReference counties =
      FirebaseFirestore.instance.collection('countiesKE');
  late List countiez;
  late List subCountiez;
  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');
  FirebaseStorage storage = FirebaseStorage.instance;
  var prodId;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Map dropDownMap = {};
  List countie = [];
  List subCountie = [];

  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final gender = TextEditingController();
  final county = TextEditingController();
  final subcounty = TextEditingController();
  final role = TextEditingController();
  final collectionPoint = TextEditingController();
  int _currentStep = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late String fileName = '';
  late File imageFile;

  @override
  initState() {
    var rand = getRandomString(5);
    prodId = rand;
    super.initState();
    // invDoc.doc('InvDoc').get().then((DocumentSnapshot value) {
    //   value[rand].exists ? initState() : prodId = rand;
    // });
  }

  addFirestoreCollection() {}

  @override
  Widget build(BuildContext context) {
// inputField
    Widget _entryField(String title,
        {bool isPassword = false,
        var isIcon = Icons.brightness_1_sharp,
        TextEditingController? controller,
        bool isDisabled = false,
        bool isDate = false,
        bool isDropDown = false,
        TextInputType inpuType = TextInputType.text,
        List<dynamic>? dropList}) {
      return Card(
        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
        elevation: 11,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: isDropDown
            ? Container(
                width: MediaQuery.of(context).size.width - 60,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      iconEnabledColor: Color(0xFF0000E2),
                      hint: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Icon(
                              Icons.money,
                              color: Color(0xFF0000E2),
                            ),
                          ),
                          Text(
                              dropDownMap[title] == null
                                  ? title
                                  : dropDownMap[title],
                              style: TextStyle(color: Color(0xFF0000E2))),
                        ],
                      ),
                      items: dropList!.map((var value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.black)));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          dropDownMap[title] = val;
                        });
                      },
                    ),
                  ),
                ),
              )
            : TextFormField(
                keyboardType: inpuType,
                readOnly: isDate ? true : isDisabled,
                obscureText: isPassword,
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '$title cannot be empty!';
                  }

                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      isIcon,
                      color: Color(0xFF0000E2),
                    ),
                    hintText: title,
                    hintStyle: TextStyle(color: Color(0xFF0000E2)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
              ),
      );
    }

    // // Upload image to firebase
    // _upload() async {
    //   print('KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK');
    //   print(fileName);
    //   print('KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK');
    //   try {
    //     // Uploading the selected image with some custom meta data
    //     await storage.ref(fileName).putFile(
    //         imageFile,
    //         SettableMetadata(customMetadata: {
    //           'uploaded_by': 'taka connect',
    //           'description': 'Some description...'
    //         }));
    //     return storage.ref(fileName).getDownloadURL();
    //   } on FirebaseException catch (error) {
    //     print(error);
    //   }
    // }

    // // Select and image from the gallery or take a picture with the camera
    // Future<void> _select(String inputSource) async {
    //   final picker = ImagePicker();
    //   PickedFile? pickedImage;
    //   try {
    //     pickedImage = await picker.getImage(
    //         source: inputSource == 'camera'
    //             ? ImageSource.camera
    //             : ImageSource.gallery,
    //         maxWidth: 1920);

    //     setState(() {
    //       fileName = path.basename(pickedImage!.path);
    //       imageFile = File(pickedImage.path);
    //     });
    //   } catch (err) {
    //     print(err);
    //   }
    // }

    void showSnackbar(String message) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
    }

    void addUser(
        String name,
        String gender,
        List county,
        List subcounty,
        String collectionPoint,
        String role,
        String email,
        String image,
        String imageName) async {
      Map<String, String> counties = Map<String, String>();
      countie.asMap().forEach((key, value) {
        counties.putIfAbsent(key.toString(), () => value);
      });
      Map<String, String> subCounties = Map<String, String>();
      subCountie.asMap().forEach((key, value) {
        subCounties.putIfAbsent(key.toString(), () => value);
      });
      var firebaseUser = FirebaseAuth.instance.currentUser;
      setState(() {
        verifyLoading = !verifyLoading;
      });
      try {
        await userColl.doc(firebaseUser!.uid).set({
          "name": name,
          "phone": firebaseUser.phoneNumber,
          "gender": gender,
          "county": counties,
          "subcounty": subCounties,
          "collectionPoint": collectionPoint,
          "role": role,
          "email": email,
          "image": image,
          "imageName": imageName
        }).then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoryHomePage()));
          print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
          print(firebaseUser.phoneNumber);
          print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
        });
      } catch (e) {
        print('ERERERERERERRERERRERERRERERRERERRERERER');
        print(e);
        print('ERERERERERERRERERRERERRERERRERERRERERER');
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: 1100,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.black, Colors.black87],
                    [Colors.green.shade300, Colors.green.shade500],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.05, 0.10],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  // height: 700,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Card(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(
                                left: 30, right: 30, top: 30, bottom: 30),
                            elevation: 11,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70))),
                            child: Image(
                              height: 150,
                              width: 150,
                              image:
                                  Image.asset('assets/appIcons/ic_launcher.png')
                                      .image,
                            ),
                          ),
                        ),
                        Text("Signup",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0)),
                        Stepper(
                          type: StepperType.vertical,
                          onStepContinue: _currentStep < 2
                              ? () => setState(() => _currentStep += 1)
                              : _currentStep < 3
                                  ? () => name.text.isNotEmpty &&
                                          dropDownMap['Gender'].isNotEmpty &&
                                          dropDownMap['County'].isNotEmpty &&
                                          dropDownMap['Sub-County']
                                              .isNotEmpty &&
                                          dropDownMap['Collection Points']
                                              .isNotEmpty &&
                                          dropDownMap['Roles'].isNotEmpty
                                      ? addUser(
                                          name.text,
                                          dropDownMap['Gender'],
                                          countie,
                                          subCountie,
                                          dropDownMap['Collection Points'],
                                          dropDownMap['Roles'],
                                          '',
                                          '',
                                          '')
                                      : showSnackbar('Inputs cannot be empty')
                                  : () {},
                          onStepCancel: _currentStep > 0
                              ? () => setState(() => _currentStep -= 1)
                              : null,
                          currentStep: _currentStep,
                          steps: <Step>[
                            Step(
                              title: Text('Personal Detail*'),
                              content: Column(children: <Widget>[
                                _entryField('Name',
                                    controller: name,
                                    isIcon: Icons.account_circle_outlined),
                                Card(
                                    margin: EdgeInsets.only(
                                        left: 30, right: 30, top: 30),
                                    elevation: 11,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton(
                                            iconEnabledColor: Color(0xFF0000E2),
                                            hint: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Icon(
                                                    !dropDownMap.containsKey(
                                                            'Gender')
                                                        ? FontAwesomeIcons
                                                            .genderless
                                                        : dropDownMap[
                                                                    'Gender'] ==
                                                                'Male'
                                                            ? FontAwesomeIcons
                                                                .male
                                                            : dropDownMap[
                                                                        'Gender'] ==
                                                                    'Female'
                                                                ? FontAwesomeIcons
                                                                    .female
                                                                : FontAwesomeIcons
                                                                    .genderless,
                                                    color: Color(0xFF0000E2),
                                                  ),
                                                ),
                                                Text(
                                                    dropDownMap['Gender'] ==
                                                            null
                                                        ? 'Gender'
                                                        : dropDownMap['Gender'],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF0000E2))),
                                              ],
                                            ),
                                            items: ['Male', 'Female']
                                                .map((var value) {
                                              return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black)));
                                            }).toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                dropDownMap['Gender'] = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),
                            ),
                            Step(
                              title: Text('Location Detail*'),
                              content: Column(children: <Widget>[
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          iconEnabledColor: Color(0xFF0000E2),
                                          hint: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12),
                                                child: Icon(
                                                  Icons.map,
                                                  color: Color(0xFF0000E2),
                                                ),
                                              ),
                                              Text('County',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xFF0000E2))),
                                            ],
                                          ),
                                          items: Counties.countyList
                                              .asMap()
                                              .entries
                                              .where((element) =>
                                                  element.value.name !=
                                                  'default')
                                              .map((val) {
                                            return DropdownMenuItem(
                                                value: val.value.name,
                                                onTap: () {
                                                  !countie.contains(
                                                          val.value.name)
                                                      ? countie
                                                          .add(val.value.name)
                                                      : countie.remove(
                                                          val.value.name);
                                                  print(
                                                      'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY');
                                                  print(countie.length > 0);
                                                  print(countie.isEmpty);
                                                  print(countie);
                                                  print(
                                                      'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY');
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(val.value.name),
                                                    Icon(
                                                      !countie.contains(
                                                              val.value.name)
                                                          ? Icons
                                                              .check_box_outline_blank
                                                          : Icons.check_box,
                                                      color: Colors.green[600],
                                                    ),
                                                  ],
                                                ));
                                          }).toList(),
                                          onChanged: (v) {
                                            setState(() {
                                              dropDownMap['County'] = v;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: countie.isNotEmpty,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 30, right: 30, top: 30),
                                    elevation: 11,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton(
                                            iconEnabledColor: Color(0xFF0000E2),
                                            hint: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Icon(
                                                    Icons.maps_home_work_sharp,
                                                    color: Color(0xFF0000E2),
                                                  ),
                                                ),
                                                Text('Sub-County',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF0000E2))),
                                              ],
                                            ),
                                            items: Counties.countyList
                                                .asMap()
                                                .entries
                                                .where((element) =>
                                                    element.value.name !=
                                                    'default')
                                                .where((element) =>
                                                    countie.contains(
                                                        element.value.name))
                                                .map((v) => v.value.subCounties)
                                                .toList()
                                                .expand((x) {
                                                  return x;
                                                })
                                                .toList()
                                                .asMap()
                                                .entries
                                                .map((val) {
                                                  return DropdownMenuItem(
                                                      value: val.value,
                                                      onTap: () {
                                                        !subCountie.contains(
                                                                val.value)
                                                            ? subCountie
                                                                .add(val.value)
                                                            : subCountie.remove(
                                                                val.value);
                                                        print(
                                                            'GHHHGHGHGHGHGHGHGHGHGHGHGHGHHH');
                                                        print(
                                                            subCountie.length >
                                                                0);
                                                        print(
                                                            subCountie.isEmpty);
                                                        print(
                                                            subCountie.contains(
                                                                val.value));
                                                        print(subCountie);
                                                        print(
                                                            'GHHHGHGHGHGHGHGHGHGHGHGHGHGHHH');
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(val.value),
                                                          Icon(
                                                            !subCountie.contains(
                                                                    val.value)
                                                                ? Icons
                                                                    .check_box_outline_blank
                                                                : Icons
                                                                    .check_box,
                                                            color: Colors
                                                                .green[600],
                                                          ),
                                                        ],
                                                      ));
                                                })
                                                .toList(),
                                            onChanged: (v) {
                                              setState(() {
                                                dropDownMap['Sub-County'] = v;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            Step(
                              title: Text('Taka Detail*'),
                              content: Column(children: <Widget>[
                                _entryField('Collection Points',
                                    isDropDown: true,
                                    isIcon: Icons.maps_ugc_rounded,
                                    dropList: ['point1', 'point2', 'point3']),
                                _entryField('Roles',
                                    isDropDown: true,
                                    isIcon: Icons.group_work,
                                    dropList: [
                                      'Collectors',
                                      'Buyers',
                                      'Recyclers'
                                    ])
                              ]),
                            ),
                            // Step(
                            //   title: Text('Optional Details'),
                            //   content: Column(children: <Widget>[
                            //     Card(
                            //       margin: EdgeInsets.only(
                            //           left: 30, right: 30, top: 30),
                            //       elevation: 11,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(40))),
                            //       child: TextFormField(
                            //         controller: email,
                            //         decoration: InputDecoration(
                            //             prefixIcon: Icon(
                            //               Icons.email,
                            //               color: Colors.green.shade400,
                            //             ),
                            //             hintText: "Email",
                            //             hintStyle: TextStyle(
                            //                 color: Colors.green.shade400),
                            //             filled: true,
                            //             fillColor: Colors.white,
                            //             border: OutlineInputBorder(
                            //               borderSide: BorderSide.none,
                            //               borderRadius: BorderRadius.all(
                            //                   Radius.circular(40.0)),
                            //             ),
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 horizontal: 20.0, vertical: 16.0)),
                            //       ),
                            //     ),
                            //     Column(
                            //       children: <Widget>[
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceEvenly,
                            //           children: [
                            //             ElevatedButton.icon(
                            //                 onPressed: () => _select('camera'),
                            //                 icon: Icon(Icons.camera),
                            //                 label: Text('camera')),
                            //             ElevatedButton.icon(
                            //                 onPressed: () => _select('gallery'),
                            //                 icon: Icon(Icons.library_add),
                            //                 label: Text('Gallery')),
                            //           ],
                            //         ),
                            //         Row(
                            //           children: <Widget>[
                            //             Text('File:'),
                            //             Flexible(
                            //               child: Text(
                            //                   fileName.isNotEmpty
                            //                       ? fileName
                            //                       // ignore: null_check_always_fails
                            //                       : null!,
                            //                   maxLines: 1,
                            //                   softWrap: false,
                            //                   overflow: TextOverflow.fade),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ]),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Container(
                        //   width: double.infinity,
                        //   padding: EdgeInsets.all(30.0),
                        //   // ignore: deprecated_member_use
                        //   child: RaisedButton(
                        //     padding: EdgeInsets.symmetric(vertical: 16.0),
                        //     color: Colors.teal.shade900,
                        //     onPressed: () {},
                        //     elevation: 11,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(40.0))),
                        //     child: Text("Signup",
                        //         style: TextStyle(color: Colors.white70)),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 140,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text("Already have an account?"),
              //     // ignore: deprecated_member_use
              //     FlatButton(
              //       child: Text("Sign in"),
              //       textColor: Colors.teal.shade900,
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => CategoryHomePage()));
              //       },
              //     )
              //   ],
              // )
            ],
          ),
          Visibility(
            visible: verifyLoading,
            child: Container(
              color: Colors.white60,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child:
                      // CircularProgressIndicator(),
                      FlareActor(
                    'assets/loading.flr',
                    animation: 'loading',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
