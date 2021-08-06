import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takaconnect/auth/signIn.dart';
import 'package:takaconnect/auxiliary/analytics.dart';
import 'package:takaconnect/auxiliary/feedback_screen.dart';
import 'package:takaconnect/auxiliary/help_screen.dart';
import 'package:takaconnect/auxiliary/messageProfiles.dart';
import 'package:takaconnect/auxiliary/profile.dart';
import 'package:takaconnect/utils/navbar1.dart';
import 'package:takaconnect/views/cardIconView.dart';
import 'package:takaconnect/views/cardList.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CategoryHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late TextEditingController searchController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference userDoc =
      FirebaseFirestore.instance.collection('users');
  Map uzer = {};

  Future getUser() async {
    await userDoc.doc(firebaseUser!.uid).get().then((value) => setState(() {
          uzer = value.data() as Map<String, dynamic>;
        }));
  }

  @override
  void initState() {
    getUser();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  CategoryType categoryType = CategoryType.ui;
  // ignore: deprecated_member_use
  RaisedButton category(double tr, double tl, double br, double bl, Color color,
      Widget route, String assetImage, IconData icon, String assetText) {
    // ignore: deprecated_member_use
    return RaisedButton(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(tr),
        bottomLeft: Radius.circular(bl),
        topLeft: Radius.circular(tl),
        bottomRight: Radius.circular(br),
      )),
      color: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(tr),
            bottomLeft: Radius.circular(bl),
            topLeft: Radius.circular(tl),
            bottomRight: Radius.circular(br),
          ),
          // image: DecorationImage(
          //   colorFilter: ColorFilter.mode(
          //       Color.fromRGBO(255, 255, 255, 0.65), BlendMode.dstATop),
          //   image: ExactAssetImage(assetImage),
          //   fit: BoxFit.cover,
          // ),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment(
          //       0.8, 0.0), // 10% of the width, so there are ten blinds.
          //   colors: [
          //     Colors.white10.withOpacity(0.85),
          //     Colors.white10.withOpacity(0.65),
          //     Colors.white10.withOpacity(0.45),
          //     const Color(0x34000000)
          //   ], // red to yellow
          //   // colors: [
          //   //   color.withOpacity(0.85),
          //   //   color.withOpacity(0.65),
          //   //   color.withOpacity(0.45),
          //   //   const Color(0xCC000000)
          //   // ], // red to yellow
          //   tileMode: TileMode.repeated, // repeats the gradient over the canvas
          // ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: color,
                  child: Icon(icon, size: 35.0, color: Colors.white)),
            ),
            Spacer(
              flex: 1,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                assetText,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar1(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text(uzer['role'] ?? 'TakaConnect')),
        iconTheme: IconThemeData(color: Colors.white),
        // automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 5.4,
            child: RotatedBox(
              quarterTurns: 4,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.black, Colors.black87],
                    [Colors.green.shade300, Colors.green.shade500],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.24, 0.27],
                  blur: MaskFilter.blur(BlurStyle.solid, 12),
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
          Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .27,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: CardIconView(
                        teamMember: Team.category[0],
                        title: uzer['role'],
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .05,
                    //   child: Container(
                    //     padding: EdgeInsets.only(bottom: 4, top: 4),
                    //     color: Colors.green.shade400,
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.only(top: 75, bottom: 2),
                      height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 16.0, top: 2.0, bottom: 2.0),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        children: <Widget>[
                          category(
                              0.0,
                              22.0,
                              0.0,
                              22.0,
                              Colors.blueGrey,
                              // AnalysisPage(),
                              AnalysisPage(),
                              'assets/background/pexels-mohamed-abdelgaffar-771742.jpg',
                              Icons.analytics_rounded,
                              'My Data'),
                          category(
                              22.0,
                              0.0,
                              22.0,
                              0.0,
                              Colors.teal,
                              MessageProfiles(role: uzer['role']),
                              'assets/background/pexels-aradhana-2697288.jpg',
                              Icons.message,
                              'Messaging'),
                          category(
                              0.0,
                              22.0,
                              22.0,
                              22.0,
                              Colors.blueAccent,
                              HelpScreen(),
                              'assets/background/pexels-pixabay-264547.jpg',
                              Icons.help_outline,
                              'Help'),
                          category(
                              22.0,
                              0.0,
                              22.0,
                              22.0,
                              Colors.orange,
                              Profile(),
                              'assets/background/fabio-oyXis2kALVg-unsplash.jpg',
                              Icons.person,
                              'Profile'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
