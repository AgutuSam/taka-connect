import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:takaconnect/auxiliary/messageThread.dart';
import 'package:takaconnect/utils/alert.dart';

class MessageProfiles extends StatefulWidget {
  const MessageProfiles({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  _MessageProfilesState createState() => _MessageProfilesState();
}

class _MessageProfilesState extends State<MessageProfiles> {
  final auth = FirebaseAuth.instance.currentUser;
  final CollectionReference messagesDoc =
      FirebaseFirestore.instance.collection('messages');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: messagesDoc
              .doc(auth!.uid)
              .collection('pals')
              .orderBy('timestamp')
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child:
                        //  CircularProgressIndicator(),
                        FlareActor(
                      'assets/loading.flr',
                      animation: 'loading',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            } else {
              List<DocumentSnapshot> data = snapshot.data!.docs;
              return data.isEmpty
                  ? BeautifulAlertDialog(widget.role == 'Recyclers' ||
                          widget.role == 'Buyers'
                      ? 'You do not have any thread yet! Start a thread with a preffered collector!'
                      : 'You do not have any thread as of yet!')
                  : Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List<Widget>.generate(data.length, (int index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessageThread(
                                              palid: data[index].id)));
                                },
                                // isThreeLine: true,
                                leading: CircleAvatar(
                                  child: Text(
                                    '${data[index]['palname'][0]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  radius: 14.0,
                                  backgroundColor: Colors.green,
                                  // backgroundImage: Image.asset(model.imagePath).image,
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      '${data[index]['palname']}',
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      width: 20,
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
          }),
    );
  }
}
