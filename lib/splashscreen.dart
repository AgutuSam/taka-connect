import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

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
              Navigator.push(context,
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
                      Navigator.push(
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
