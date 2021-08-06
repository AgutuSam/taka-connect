import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:takaconnect/auth/signUp.dart';
import 'package:takaconnect/auxiliary/terms_and_conditions.dart';
import 'package:takaconnect/modules/categories.dart';
import 'package:takaconnect/modules/categoryHome.dart';

import 'auth/signIn.dart';

class SplashScreen extends StatefulWidget {
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xff93C47D),
          ),
          TextButton(
            onPressed: () {
              // ignore: unnecessary_null_comparison
              FirebaseAuth.instance.currentUser != null
                  ? userColl
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then(
                        (doc) => doc.exists
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryHomePage()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermsAndConditions())),
                      )
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FlareActor(
                    'assets/splash.flr',
                    animation: 'takaconnect',
                    fit: BoxFit.cover,
                    callback: (_) {
                      // ignore: unnecessary_null_comparison
                      FirebaseAuth.instance.currentUser != null
                          ? userColl
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then(
                                (doc) => doc.exists
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryHomePage()))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermsAndConditions())),
                              )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SigninPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
