import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:takaconnect/auxiliary/messageThread.dart';

class WasteDialog extends StatefulWidget {
  WasteDialog({this.wasteId, this.user});
  final wasteId;
  final user;

  @override
  _WasteDialogState createState() => _WasteDialogState();
}

class _WasteDialogState extends State<WasteDialog> {
  final quantity = TextEditingController();

  User? auser = FirebaseAuth.instance.currentUser;

  final CollectionReference wasteDoc =
      FirebaseFirestore.instance.collection('waste');
  final CollectionReference userDoc =
      FirebaseFirestore.instance.collection('users');

  var prodId;

  var unitState;

  var transactionId;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  Random _rnd = Random();

  late AnimationController animationController;

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static const TextStyle label = TextStyle(
    // h6 -> title
    // fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    letterSpacing: 0.18,
    color: Colors.orange,
  );

  setFavAndRates() {
    userDoc.doc(widget.user).collection('rate').get().then((sub) async {
      if (sub.docs.length > 0) {
        print('subcollection exists');
      } else {
        await userDoc
            .doc(widget.user)
            .collection('rate')
            .doc(auser!.uid)
            .set({'rates': 0, 'rator': auser!.uid});
      }
    });
    userDoc.doc(widget.user).collection('favorite').get().then((sub) async {
      if (sub.docs.length > 0) {
        print('subcollection exists');
      } else {
        await userDoc
            .doc(widget.user)
            .collection('favorite')
            .doc('def')
            .set({});
      }
    });
  }

  @override
  void initState() {
    setFavAndRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: MediaQuery.of(context).viewInsets.bottom == 0
          ? Alignment.center
          : Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width > 1280
            ? 414
            : MediaQuery.of(context).size.width,
        child: SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom == 0
              ? MediaQuery.of(context).size.height * 0.6
              : MediaQuery.of(context).size.height * 0.9,
          child: FutureBuilder(
              future: wasteDoc
                  .doc(widget.wasteId)
                  .get()
                  .then((value) => value.data()),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: FlareActor(
                          'assets/loading.flr',
                          animation: 'loading',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }
                Map<String, dynamic> data =
                    snapshot.data! as Map<String, dynamic>;
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Taka',
                          style: TextStyle(color: Colors.green),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Category",
                              style: label,
                            ),
                            Text("Type", style: label)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(data['Waste Category']),
                            Text(data['Material Type']),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Characteristics:",
                                  style: label,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.brightness_1_sharp,
                                        color: data['Color'] == 'Red'
                                            ? Colors.red
                                            : data['Color'] == 'Orange'
                                                ? Colors.orange
                                                : data['Color'] == 'Yellow'
                                                    ? Colors.yellow
                                                    : data['Color'] == 'Green'
                                                        ? Colors.green
                                                        : data['Color'] ==
                                                                'Blue'
                                                            ? Colors.blue
                                                            : data['Color'] ==
                                                                    'Indigo'
                                                                ? Colors.indigo
                                                                : data['Color'] ==
                                                                        'Violet'
                                                                    ? Color(
                                                                        0xFF8F00FF)
                                                                    : Colors
                                                                        .transparent),
                                    SizedBox(width: 4),
                                    Text(data['Color']),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text(data['Size']),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Quality",
                                  style: label,
                                ),
                                Text(
                                  data["Quality"],
                                  style: label,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Quantity",
                                  style: label,
                                ),
                                Text(
                                  'Kilograms',
                                  style: label,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                            future: userDoc.doc(widget.user).get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              var data = snapshot.data;
                              return data != null
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'Name:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${data['name']}',
                                            style: TextStyle(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Phone:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${data['phone']}',
                                            style: TextStyle(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextButton.icon(
                                icon: Icon(Icons.message_outlined),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessageThread(
                                        palid: data['user'],
                                      ),
                                    ),
                                  );
                                },
                                label: Text(
                                  'Message',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: wasteDoc
                                      // .doc(widget.wasteId)
                                      // .collection('Request')
                                      .snapshots(),
                                  builder: (BuildContext context, snapshot) {
                                    List<DocumentSnapshot> data =
                                        snapshot.data!.docs;
                                    var res = data
                                        .where((element) =>
                                            element.id == widget.wasteId)
                                        .first;
                                    return snapshot.hasData &&
                                            res['Request']
                                                .containsKey(auser!.uid)
                                        ? TextButton.icon(
                                            icon: Icon(Icons.add),
                                            onPressed: () async {
                                              res['Request'][auser!.uid] == true
                                                  ? wasteDoc
                                                      .doc(widget.wasteId)
                                                      .update({
                                                      'Request.${auser!.uid}':
                                                          false
                                                    })
                                                  : wasteDoc
                                                      .doc(widget.wasteId)
                                                      .update({
                                                      'Request.${auser!.uid}':
                                                          true
                                                    });
                                            },
                                            label: res['Request'][auser!.uid] ==
                                                    true
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'Requested',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .smileWink,
                                                          color: Colors.green)
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'Request',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .mehRollingEyes,
                                                          color: Colors.amber)
                                                    ],
                                                  ),
                                          )
                                        : TextButton.icon(
                                            icon: Icon(Icons.add),
                                            onPressed: () async {
                                              wasteDoc
                                                  .doc(widget.wasteId)
                                                  .update({
                                                'Request.${auser!.uid}': true
                                              });
                                            },
                                            label: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Request',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.amber),
                                                ),
                                                Icon(
                                                    FontAwesomeIcons
                                                        .mehRollingEyes,
                                                    color: Colors.amber)
                                              ],
                                            ),
                                          );
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StreamBuilder<QuerySnapshot>(
                                  stream: userDoc
                                      .doc(widget.user)
                                      .collection('rate')
                                      .where('rator', isEqualTo: auser!.uid)
                                      .snapshots(),
                                  builder: (BuildContext context, snapshot) {
                                    List<DocumentSnapshot> data =
                                        snapshot.data!.docs;
                                    if (!snapshot.hasData || data.isEmpty) {
                                      return RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 0,
                                        maxRating: 5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(
                                              'JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
                                          print(rating);
                                          print(
                                              'JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
                                          userDoc
                                              .doc(widget.user)
                                              .collection('rate')
                                              .doc(auser!.uid)
                                              .set({
                                            'rates': rating,
                                            'rator': auser!.uid
                                          });
                                          print(
                                              'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
                                          print(rating);
                                          print(
                                              'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
                                        },
                                      );
                                    } else {
                                      return RatingBar.builder(
                                        initialRating: data.first['rates'] == 0
                                            ? 0
                                            // : 3.5,
                                            : data.first['rates'],
                                        minRating: 0,
                                        maxRating: 5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(
                                              'JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
                                          print(rating);
                                          print(
                                              'JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ');
                                          userDoc
                                              .doc(widget.user)
                                              .collection('rate')
                                              .doc(auser!.uid)
                                              .set({
                                            'rates': rating,
                                            'rator': auser!.uid
                                          });
                                          print(
                                              'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
                                          print(rating);
                                          print(
                                              'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
                                        },
                                      );
                                    }
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: userDoc
                                      .doc(widget.user)
                                      .collection('favorite')
                                      .snapshots(),
                                  builder: (BuildContext context, snapshot) {
                                    List<DocumentSnapshot> data =
                                        snapshot.data!.docs;
                                    if (!snapshot.hasData || data.isEmpty) {
                                      return LikeButton(
                                        // size: buttonSize,
                                        circleColor: CircleColor(
                                            start: Color(0xff00ddff),
                                            end: Color(0xff0099cc)),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: Color(0xff33b5e5),
                                          dotSecondaryColor: Color(0xff0099cc),
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            Icons.favorite,
                                            color: isLiked
                                                ? Colors.deepPurpleAccent
                                                : Colors.grey,
                                            // size: buttonSize,
                                          );
                                        },
                                        likeCount: 0,
                                        countBuilder: (int? count, bool isLiked,
                                            String text) {
                                          var color = isLiked
                                              ? Colors.deepPurpleAccent
                                              : Colors.grey;
                                          Widget result;
                                          result = Text(
                                            "Favorite",
                                            style: TextStyle(color: color),
                                          );
                                          return result;
                                        },
                                        onTap: (state) async {
                                          print('KKKKKKKKKKKKKKKKKKKKKKK');
                                          print(state);
                                          print('KKKKKKKKKKKKKKKKKKKKKKK');

                                          state
                                              ? userDoc
                                                  .doc(widget.user)
                                                  .collection('favorite')
                                                  .doc(auser!.uid)
                                                  .set({'user': auser!.uid})
                                              : userDoc
                                                  .doc(widget.user)
                                                  .collection('favorite')
                                                  .doc(auser!.uid)
                                                  .delete();

                                          return !state;
                                        },
                                      );
                                    } else {
                                      return LikeButton(
                                        // size: buttonSize,
                                        circleColor: CircleColor(
                                            start: Color(0xff00ddff),
                                            end: Color(0xff0099cc)),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: Color(0xff33b5e5),
                                          dotSecondaryColor: Color(0xff0099cc),
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            Icons.favorite,
                                            color: isLiked
                                                ? Colors.deepPurpleAccent
                                                : Colors.grey,
                                            // size: buttonSize,
                                          );
                                        },
                                        likeCount: data.length - 1,
                                        countBuilder: (int? count, bool isLiked,
                                            String text) {
                                          var color = isLiked
                                              ? Colors.deepPurpleAccent
                                              : Colors.grey;
                                          Widget result;
                                          if (data.length - 1 < 0) {
                                            result = Text(
                                              "Favorite",
                                              style: TextStyle(color: color),
                                            );
                                          } else
                                            result = Text(
                                              text,
                                              style: TextStyle(color: color),
                                            );
                                          return result;
                                        },
                                        onTap: (state) async {
                                          print('KKKKKKKKKKKKKKKKKKKKKKK');
                                          print(state);
                                          print('KKKKKKKKKKKKKKKKKKKKKKK');

                                          state
                                              ? userDoc
                                                  .doc(widget.user)
                                                  .collection('favorite')
                                                  .doc(auser!.uid)
                                                  .set({'user': auser!.uid})
                                              : userDoc
                                                  .doc(widget.user)
                                                  .collection('favorite')
                                                  .doc(auser!.uid)
                                                  .delete();
                                          return !state;
                                        },
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
