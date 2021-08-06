import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:takaconnect/auxiliary/messageThread.dart';

class WasteDialog extends StatefulWidget {
  WasteDialog({this.wasteId});
  final wasteId;

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
                    padding: const EdgeInsets.all(16.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(data['Characteristics']),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
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
                                  '${data["Quantity"] + " " + data["Scale"]}',
                                  style: label,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessageThread(
                                  palid: data['user'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.messenger_outline_sharp,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Message',
                                      style: label,
                                    ),
                                    // IconButton(
                                    //     onPressed: () {
                                    //       Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               MessageThread(
                                    //             palid: data['user'],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //     icon: Icon(Icons.message_outlined))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                                stream: userDoc
                                    .doc(widget.wasteId)
                                    .collection('rate')
                                    .where('rator', isEqualTo: auser!.uid)
                                    .snapshots(),
                                builder: (BuildContext context, snapshot) {
                                  List<DocumentSnapshot> data =
                                      snapshot.data!.docs;
                                  return RatingBar.builder(
                                    initialRating: data.isEmpty ||
                                            int.parse(data.first['rates']
                                                    .toString()) ==
                                                0
                                        ? 0
                                        : double.parse(
                                            data.first['rates'].toString()),
                                    minRating: 0,
                                    maxRating: 5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      userDoc
                                          .doc(widget.wasteId)
                                          .collection('rate')
                                          .doc(auser!.uid)
                                          .set({
                                        'rates': rating,
                                        'rator': auser!.uid
                                      });
                                      print(rating);
                                    },
                                  );
                                }),
                            StreamBuilder<QuerySnapshot>(
                                stream: userDoc
                                    .doc(widget.wasteId)
                                    .collection('favorite')
                                    .snapshots(),
                                builder: (BuildContext context, snapshot) {
                                  List<DocumentSnapshot> data =
                                      snapshot.data!.docs;
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
                                    likeCount: data.length,
                                    countBuilder: (int? count, bool isLiked,
                                        String text) {
                                      var color = isLiked
                                          ? Colors.deepPurpleAccent
                                          : Colors.grey;
                                      Widget result;
                                      if (data.length == 0 || data.isEmpty) {
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
                                      state
                                          ? userDoc
                                              .doc(widget.wasteId)
                                              .collection('favorite')
                                              .doc(auser!.uid)
                                              .set({})
                                          : userDoc
                                              .doc(widget.wasteId)
                                              .collection('favorite')
                                              .doc(auser!.uid)
                                              .delete();
                                      return state;
                                    },
                                  );
                                }),
                          ],
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
