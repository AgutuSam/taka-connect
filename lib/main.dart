import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:takaconnect/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(147, 196, 125, .1),
      100: Color.fromRGBO(147, 196, 125, .2),
      200: Color.fromRGBO(147, 196, 125, .3),
      300: Color.fromRGBO(147, 196, 125, .4),
      400: Color.fromRGBO(147, 196, 125, .5),
      500: Color.fromRGBO(147, 196, 125, .6),
      600: Color.fromRGBO(147, 196, 125, .7),
      700: Color.fromRGBO(147, 196, 125, .8),
      800: Color.fromRGBO(147, 196, 125, .9),
      900: Color.fromRGBO(147, 196, 125, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF93C47D, color);
    return MaterialApp(
      title: 'Taka Connect',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: SplashScreen(),
    );
  }
}
