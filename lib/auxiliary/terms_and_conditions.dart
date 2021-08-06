import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takaconnect/auth/signUp.dart';
import 'package:takaconnect/modules/categories.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('TakaConnect'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  // padding: const EdgeInsets.fromLTRB(20.0, 24.0, 0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      height: 100,
                      width: 100,
                      image:
                          Image.asset('assets/appIcons/ic_launcher.png').image,
                    ),
                  ),
                ),
                Center(
                  // padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, //.horizontal
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'These Terms of Use constitute a legally binding agreement made between you,' +
                              'whether personally or on behalf of an entity (“you”) and TakaConnect (“Company”,' +
                              '“we”, “us”, or “our”), concerning your access to and use of the' +
                              'TakaConnect App as well as any other media form, media channel or' +
                              'mobile website related, linked, or otherwise connected' +
                              'thereto (collectively, the “Application”). You agree that by' +
                              'accessing the App, you have read, understood, and agreed to be bound by all of' +
                              'these Terms of Use. IF YOU DO NOT AGREE WITH ALL OF THESE TERMS OF' +
                              'USE, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE APP AND' +
                              'YOU MUST DISCONTINUE USE IMMEDIATELY!',
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Material(
                  child: Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value!;
                      });
                    },
                  ),
                ),
                Text(
                  'I have read and accept terms and conditions',
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: agree
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage('default')))
                      : null,
                  child: Text('Continue')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getColor)),
                  onPressed: () => exit(0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
