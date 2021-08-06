import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:contactus/contactus.dart';
import 'package:takaconnect/utils/navbar1.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      drawer: NavBar1(),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Nivlec',
        textColor: Colors.white,
        backgroundColor: Colors.teal,
        email: 'info@nivlec.com',
        // textFont: 'Sail',
      ),
      backgroundColor: Colors.teal.shade300,
      body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: AssetImage('assets/appIcons/ic_launcher.png'),
          email: 'info@takaconnect.com',
          companyName: 'Taka Connect',
          companyColor: Colors.teal.shade100,
          phoneNumber: '+25412345678',
          website: 'https://takaconnect.com',
          githubUserName: 'taka_Connect',
          linkedinURL: 'https://www.linkedin.com/in/taka-connect-520983199/',
          tagLine: 'Plastic Free Life',
          taglineColor: Colors.teal.shade100,
          twitterHandle: 'takaconnect',
          instagram: '_taka_connect',
          facebookHandle: 'taka~connect'),
    );
  }
}
