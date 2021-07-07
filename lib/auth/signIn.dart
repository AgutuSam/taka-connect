import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:takaconnect/auth/signUp.dart';
import 'package:takaconnect/modules/categories.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SigninPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigninPageState();
  }
}

class _SigninPageState extends State<SigninPage> {
  late bool verifyLoading = false;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  late String _verificationId;
  // final SmsAutoFill _autoFill = SmsAutoFill();
  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showSnackbar(String message) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
    }

    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    //Callback for when the code is sent
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      setState(() {
        verifyLoading = !verifyLoading;
      });
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId.substring(0, 12));
      _verificationId = verificationId;
    };
    //Callback for when the user has already previously signed in with this phone number on this device
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      // await _auth.signInWithCredential(phoneAuthCredential);
      try {
        final User? user =
            (await _auth.signInWithCredential(phoneAuthCredential)).user;

        showSnackbar(
            "Phone number automatically verified and user signed in: ${user!.uid}");
        var doc = await userColl.doc(_auth.currentUser!.uid).get();
        doc.exists
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeCategories()))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupPage('default')));
      } catch (e) {
        // showSnackbar("Failed to sign in: " + e.toString());
      }
    };

    void verifyPhoneNumber() async {
      try {
        setState(() {
          verifyLoading = !verifyLoading;
        });
        await _auth.verifyPhoneNumber(
            phoneNumber: _phoneNumberController.text.substring(0, 2) == '07'
                ? '+254${_phoneNumberController.text.substring(1, _phoneNumberController.text.length)}'
                : _phoneNumberController.text,
            timeout: const Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      } catch (e) {
        setState(() {
          verifyLoading = !verifyLoading;
        });
        showSnackbar("Failed to Verify Phone Number: $e");
      }
    }

    void signInWithPhoneNumber() async {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _smsController.text,
        );

        final User? user = (await _auth.signInWithCredential(credential)).user;

        showSnackbar("Successfully signed in UID: ${user!.uid}");
        var doc = await userColl.doc(_auth.currentUser!.uid).get();
        doc.exists
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeCategories()))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupPage('default')));
      } catch (e) {
        showSnackbar("Failed to sign in: " + e.toString());
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: 1000,
            child: RotatedBox(
              quarterTurns: 1,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.black, Colors.black87],
                    [Colors.green.shade300, Colors.green.shade500],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
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
                  height: 850,
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
                      Text("Signin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0)),
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone cannot be Null!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.green.shade400,
                              ),
                              hintText: "Phone",
                              hintStyle:
                                  TextStyle(color: Colors.green.shade400),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Container(
                          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                          //   alignment: Alignment.center,
                          //   // ignore: deprecated_member_use
                          //   child: RaisedButton(
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(12))),
                          //       child: Text("Get current number"),
                          //       onPressed: () async => {
                          //             _phoneNumberController.text =
                          //                 (await _autoFill.hint).toString()
                          //           },
                          //       color: Colors.green.shade800),
                          // ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(30.0),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              color: Colors.teal.shade800,
                              onPressed: () async {
                                verifyPhoneNumber();
                              },
                              elevation: 11,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60.0))),
                              child: Text("Verify Number",
                                  style: TextStyle(color: Colors.white70)),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          controller: _smsController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Verification Code cannot be Null!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.check_circle,
                                color: Colors.green.shade400,
                              ),
                              hintText: "Verification Code",
                              hintStyle:
                                  TextStyle(color: Colors.green.shade400),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: Colors.teal.shade900,
                          onPressed: () {
                            signInWithPhoneNumber();
                          },
                          elevation: 11,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60.0))),
                          child: Text("Signin",
                              style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text("Dont have an account?"),
                    //     // ignore: deprecated_member_use
                    //     FlatButton(
                    //       child: Text("Sign up"),
                    //       textColor: Colors.white,
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => SignupPage(),
                    //                 fullscreenDialog: true));
                    //       },
                    //     )
                    //   ],
                    // )
                  ],
                ),
              )
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
