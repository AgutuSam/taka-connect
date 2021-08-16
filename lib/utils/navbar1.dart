import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takaconnect/auth/signIn.dart';
import 'package:takaconnect/auxiliary/contact.dart';
import 'package:takaconnect/auxiliary/feedback_screen.dart';
import 'package:takaconnect/auxiliary/help_screen.dart';
import 'package:takaconnect/auxiliary/profile.dart';
import 'package:takaconnect/modules/categoryHome.dart';
import 'package:takaconnect/utils/oval-right-clipper.dart';

class NavBar1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavBar1State();
}

class _NavBar1State extends State<NavBar1> {
  final Color color1 = Color(0xffFA696C);
  final Color color2 = Color(0xffFA8165);
  final Color color3 = Color(0xffFB8964);
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  User? auser = FirebaseAuth.instance.currentUser;
  final CollectionReference userColl =
      FirebaseFirestore.instance.collection('users');

  FirebaseStorage storage = FirebaseStorage.instance;

  late String defImg;

  user() async {}

  @override
  void initState() {
    // defImg = downloadURLExample();
    user();
    downloadURLExample();
    super.initState();
  }

  Future<String> downloadURLExample() async {
    String defaultImg = await storage.ref('origami.png').getDownloadURL();
    setState(() {
      defImg = defaultImg;
    });
    return defaultImg;
  }

  void showSnackbar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SigninPage())));
    } catch (e) {
      showSnackbar('${e.toString()}');
      print(e.toString());
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return _buildDrawer(context);
  // }

  Widget build(BuildContext context) {
    // final String image = images[0];
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40, top: 20),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FutureBuilder<DocumentSnapshot>(
                      future: userColl.doc(auser!.uid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> user =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Column(
                            children: <Widget>[
                              Container(
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: Image.asset(
                                            'assets/appIcons/ic_launcher.png')
                                        .image,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                // ignore: unnecessary_null_comparison
                                '${user['name']}' != null &&
                                        '${user['name']}' != 'null'
                                    ? '${user['name']}'
                                    : 'Anonymous User',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                // ignore: unnecessary_null_comparison
                                '${auser?.phoneNumber}' != null
                                    ? '${auser?.phoneNumber}'
                                    : '+2547 xx xxx xxxx',
                                style: TextStyle(color: active, fontSize: 16.0),
                              ),
                            ],
                          );
                        }
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, 'Home', context, CategoryHomePage()),
                  _buildDivider(),
                  _buildRow(Icons.person, 'Profile', context, Profile()),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, 'Help', context, HelpScreen()),
                  _buildDivider(),
                  _buildRow(Icons.report, 'Report a problem', context,
                      FeedbackScreen()),
                  _buildDivider(),
                  _buildRow(Icons.phone, 'Contact Us', context, Contact()),
                  _buildDivider(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: .2),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: _signOut,
                      child: Row(children: [
                        Icon(
                          Icons.power_settings_new,
                          color: active,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'LogOut',
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),
                        Spacer(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(
      IconData icon, String title, BuildContext context, Widget route,
      {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: .2),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => route));
        },
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  '10+',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }

  // //FileUpload
  // Future uploadFile() async {
  //   String filepath;
  //   final ByteData bytes = await rootBundle.load(filepath);
  //   final Directory tempDir = Directory.systemTemp;
  //   String filename; //filename
  //   File file; //file
  //   file.writeAsBytes(bytes.buffer.asUint8List(), mode: FileMode.write);

  //   final StorageReference ref = FirebaseStorage.instance.ref().child(filename);
  //   final StorageUploadTask task = ref.putFile(file);
  //   // final Uri downloadUrl = (await task).downloadUrl;

  //   // String path = downloadUrl.toString();
  // }
}
