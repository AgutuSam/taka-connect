import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takaconnect/auth/signIn.dart';
import 'package:takaconnect/modules/categories.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final gender = TextEditingController();
  final county = TextEditingController();
  final subcounty = TextEditingController();
  final role = TextEditingController();
  final collectionPoint = TextEditingController();
  int _currentStep = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');

  addFirestoreCollection() {}

  @override
  Widget build(BuildContext context) {
    void showSnackbar(String message) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
    }

    void addUser(String name, String gender, String county, String subcounty,
        String collectionPoint, String role) async {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      print('UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU');
      print(firebaseUser!.uid);
      print('UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU');
      try {
        await userColl.doc(firebaseUser.uid).set({
          "name": name,
          "phone": firebaseUser.phoneNumber,
          "gender": gender,
          "county": county,
          "subcounty": subcounty,
          "collectionPoint": collectionPoint,
          "role": role
        }).then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeCategories()));
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
                  height: 700,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Card(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(
                                left: 30, right: 30, top: 20, bottom: 20),
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
                                  ? () => name.text.isNotEmpty ||
                                          gender.text.isNotEmpty ||
                                          county.text.isNotEmpty ||
                                          subcounty.text.isNotEmpty ||
                                          collectionPoint.text.isNotEmpty ||
                                          role.text.isNotEmpty
                                      ? addUser(
                                          name.text,
                                          gender.text,
                                          county.text,
                                          subcounty.text,
                                          collectionPoint.text,
                                          role.text)
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
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextFormField(
                                    controller: name,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.green.shade400,
                                        ),
                                        hintText: "Names",
                                        hintStyle: TextStyle(
                                            color: Colors.green.shade400),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextFormField(
                                    controller: gender,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.category_rounded,
                                          color: Colors.green.shade400,
                                        ),
                                        hintText: "Gender",
                                        hintStyle: TextStyle(
                                            color: Colors.green.shade400),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
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
                                          Radius.circular(40))),
                                  child: TextFormField(
                                    controller: county,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.flag,
                                          color: Colors.green.shade400,
                                        ),
                                        hintText: "County",
                                        hintStyle: TextStyle(
                                            color: Colors.green.shade400),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextFormField(
                                    controller: subcounty,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.map,
                                          color: Colors.green.shade400,
                                        ),
                                        hintText: "Sub County",
                                        hintStyle: TextStyle(
                                            color: Colors.green.shade400),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                              ]),
                            ),
                            Step(
                              title: Text('Taka Detail*'),
                              content: Column(children: <Widget>[
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextFormField(
                                    controller: collectionPoint,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.pin_drop,
                                          color: Colors.green.shade400,
                                        ),
                                        hintText: "Collection Point",
                                        hintStyle: TextStyle(
                                            color: Colors.green.shade400),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  elevation: 11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: TextFormField(
                                    controller: role,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.work,
                                          color: Colors.green.shade400,
                                        ),
                                        hintText: "Role",
                                        hintStyle: TextStyle(
                                            color: Colors.green.shade400),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16.0)),
                                  ),
                                ),
                              ]),
                            ),
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
              //                 builder: (context) => HomeCategories()));
              //       },
              //     )
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
