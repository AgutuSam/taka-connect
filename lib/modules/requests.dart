import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takaconnect/auxiliary/messageThread.dart';
import 'package:takaconnect/utils/alert.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final CollectionReference userDoc =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference wasteDoc =
      FirebaseFirestore.instance.collection('waste');
  User? auser = FirebaseAuth.instance.currentUser;

  Map uzer = {};

  Future getUser() async {
    await userDoc.doc(auser!.uid).get().then((value) => setState(() {
          uzer = value.data() as Map<String, dynamic>;
        }));
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Requests'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: wasteDoc.snapshots(),
            builder: (BuildContext context, snapshot) {
              List<DocumentSnapshot> data = snapshot.data!.docs;
              if (!snapshot.hasData) {
                return BeautifulAlertDialog('No requests available as of yet!');
              }
              List reqs = data.asMap().entries.map((res) => res.value).toList();
              return reqs.length < 1
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: reqs.length,
                      itemBuilder: (BuildContext context, index) {
                        var wasteID = data.toList()[index].id;
                        var val = reqs[index]!;
                        List req = val!['Request']!
                            .entries
                            .where((v) => v!.value == true)
                            .map((res) {
                          return res!.key;
                        }).toList();
                        print('BBBBBBBBBBBBBBBBBB');
                        print(val!['Request']!);
                        print(req);
                        print(wasteID);
                        print('BBBBBBBBBBBBBBBBBB');
                        return uzer['role']! == 'Collectors'
                            ? val!['user']! == auser!.uid &&
                                    req.length > 0 &&
                                    !val!['State']
                                ? Card(
                                    margin: EdgeInsets.all(8),
                                    elevation: 12,
                                    shadowColor: Colors.black54,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          color: Colors.amberAccent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      'Waste Category:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    Text(
                                                      '${val['Waste Category']}',
                                                      style: TextStyle(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      'Material Type:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    Text(
                                                      '${val['Material Type']}',
                                                      style: TextStyle(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                                children: req
                                                    .asMap()
                                                    .entries
                                                    .map((uzer) => Column(
                                                          children: <Widget>[
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                FutureBuilder(
                                                                    future: userDoc
                                                                        .doc(uzer
                                                                            .value)
                                                                        .get(),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot
                                                                            snapshot) {
                                                                      var data =
                                                                          snapshot
                                                                              .data;
                                                                      return Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: <
                                                                            Widget>[
                                                                          data != null
                                                                              ? Row(
                                                                                  children: <Widget>[
                                                                                    Expanded(
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            'Name:',
                                                                                            style: TextStyle(fontWeight: FontWeight.w800),
                                                                                          ),
                                                                                          Text(
                                                                                            '${data['name']}',
                                                                                            style: TextStyle(),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            'Phone:',
                                                                                            style: TextStyle(fontWeight: FontWeight.w800),
                                                                                          ),
                                                                                          Text(
                                                                                            '${data['phone']}',
                                                                                            style: TextStyle(),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                        ],
                                                                      );
                                                                    }),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    TextButton.icon(
                                                                        onPressed: () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => MessageThread(
                                                                                palid: uzer.value,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        icon: Icon(FontAwesomeIcons.envelopeOpenText),
                                                                        label: Text('Message')),
                                                                    TextButton.icon(
                                                                        onPressed: () async {
                                                                          wasteDoc
                                                                              .doc(
                                                                                  wasteID)
                                                                              .update({
                                                                            'State':
                                                                                true,
                                                                            'Alien':
                                                                                uzer.value
                                                                          });
                                                                        },
                                                                        icon: Icon(FontAwesomeIcons.check),
                                                                        label: Text('Accept')),
                                                                    TextButton.icon(
                                                                        onPressed: () async {
                                                                          wasteDoc
                                                                              .doc(
                                                                                  wasteID)
                                                                              .update({
                                                                            'Request.${uzer.value}':
                                                                                false
                                                                          });
                                                                        },
                                                                        icon: Icon(FontAwesomeIcons.times),
                                                                        label: Text('Deny')),
                                                                    _buildDivider(),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            _buildDivider(),
                                                          ],
                                                        ))
                                                    .toList()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : val['State'] &&
                                        val['Alien'] != null &&
                                        val['Alien'] != ''
                                    ? Card(
                                        margin: EdgeInsets.all(8),
                                        elevation: 12,
                                        shadowColor: Colors.black54,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              color: Colors.amberAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          'Waste Category:',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        Text(
                                                          '${val['Waste Category']}',
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          'Material Type:',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        Text(
                                                          '${val['Material Type']}',
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                    children: req
                                                        .asMap()
                                                        .entries
                                                        .where((element) =>
                                                            element.value ==
                                                            val['Alien'])
                                                        .map((uzer) => Column(
                                                              children: <
                                                                  Widget>[
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: <
                                                                      Widget>[
                                                                    FutureBuilder(
                                                                        future: userDoc
                                                                            .doc(val[
                                                                                'Alien'])
                                                                            .get(),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot
                                                                                snapshot) {
                                                                          var data =
                                                                              snapshot.data;
                                                                          return Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: <Widget>[
                                                                              data != null
                                                                                  ? Row(
                                                                                      children: <Widget>[
                                                                                        Expanded(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                'Name:',
                                                                                                style: TextStyle(fontWeight: FontWeight.w800),
                                                                                              ),
                                                                                              Text(
                                                                                                '${data['name']}',
                                                                                                style: TextStyle(),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                'Phone:',
                                                                                                style: TextStyle(fontWeight: FontWeight.w800),
                                                                                              ),
                                                                                              Text(
                                                                                                '${data['phone']}',
                                                                                                style: TextStyle(),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  : Container(),
                                                                            ],
                                                                          );
                                                                        }),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            Text('Accepted'),
                                                                            Icon(FontAwesomeIcons.smileWink,
                                                                                color: Colors.green),
                                                                          ],
                                                                        ),
                                                                        TextButton.icon(
                                                                            onPressed: () async {
                                                                              wasteDoc.doc(wasteID).update({
                                                                                'State': false,
                                                                                'Alien': ''
                                                                              });
                                                                            },
                                                                            icon: Icon(FontAwesomeIcons.timesCircle),
                                                                            label: Text('Revoke')),
                                                                        _buildDivider(),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                _buildDivider(),
                                                              ],
                                                            ))
                                                        .toList()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container()
                            : req.contains(auser!.uid)
                                ? Card(
                                    margin: EdgeInsets.all(8),
                                    elevation: 12,
                                    shadowColor: Colors.black54,
                                    child: Column(
                                      children: <Widget>[
                                        FutureBuilder(
                                            future:
                                                userDoc.doc(val['user']).get(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              var data = snapshot.data;
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  data != null
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      'Name:',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w800),
                                                                    ),
                                                                    Text(
                                                                      '${data['name']}',
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      'Phone:',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w800),
                                                                    ),
                                                                    Text(
                                                                      '${data['phone']}',
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(),
                                                  _buildDivider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            Text(
                                                              'Waste Category:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${val['Waste Category']}',
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            Text(
                                                              'Material Type:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${val['Material Type']}',
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      TextButton.icon(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MessageThread(
                                                                  palid: val[
                                                                      'user'],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(
                                                              FontAwesomeIcons
                                                                  .envelopeOpenText),
                                                          label:
                                                              Text('Message')),
                                                      TextButton.icon(
                                                          onPressed: () async {
                                                            wasteDoc
                                                                .doc(wasteID)
                                                                .update({
                                                              'Request.${auser!.uid}':
                                                                  false
                                                            });
                                                          },
                                                          icon: Icon(
                                                              FontAwesomeIcons
                                                                  .timesCircle),
                                                          label:
                                                              Text('Revoke')),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  )
                                : Container();
                      });
            }),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.amber,
    );
  }
}
