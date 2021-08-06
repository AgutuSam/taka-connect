import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class MessageThread extends StatefulWidget {
  MessageThread({Key? key, this.palid}) : super(key: key);
  final palid;

  @override
  _MessageThreadState createState() => _MessageThreadState();
}

class _MessageThreadState extends State<MessageThread> {
  final auth = FirebaseAuth.instance.currentUser;
  final CollectionReference messagesDoc =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference userDoc =
      FirebaseFirestore.instance.collection('users');
  TextEditingController messageController = TextEditingController();
  Map pal = {};
  Map uzer = {};

  static const styleSomebody = BubbleStyle(
    padding: BubbleEdges.all(12),
    margin: BubbleEdges.only(top: 10),
    elevation: 8,
    nip: BubbleNip.leftTop,
    color: Colors.white,
    borderColor: Colors.greenAccent,
    borderWidth: 1,
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    padding: BubbleEdges.all(12),
    margin: BubbleEdges.only(top: 10),
    elevation: 8,
    alignment: Alignment.topRight,
    nip: BubbleNip.rightTop,
    color: Color.fromARGB(255, 25, 255, 100),
    borderColor: Colors.green,
    borderWidth: 1,
  );

  Future getPalzInfo() async {
    await userDoc.doc(widget.palid).get().then((value) => setState(() {
          pal = value.data() as Map<String, dynamic>;
        }));
    await userDoc.doc(auth!.uid).get().then((value) => setState(() {
          uzer = value.data() as Map<String, dynamic>;
        }));
  }

  @override
  void initState() {
    getPalzInfo();
    super.initState();
  }

  void addNewMessage() {
    try {
      messagesDoc.doc(auth!.uid).collection('pals').doc(widget.palid).set(
          {'palname': pal['name'], 'timestamp': FieldValue.serverTimestamp()});
      messagesDoc.doc(widget.palid).collection('pals').doc(auth!.uid).set(
          {'palname': uzer['name'], 'timestamp': FieldValue.serverTimestamp()});
      messagesDoc
          .doc(auth!.uid)
          .collection('pals')
          .doc(widget.palid)
          .collection('thread')
          .add({
        'message': messageController.text,
        'sender': 'me',
        'timestamp': FieldValue.serverTimestamp()
      });
      messagesDoc
          .doc(widget.palid)
          .collection('pals')
          .doc(auth!.uid)
          .collection('thread')
          .add({
        'message': messageController.text,
        'sender': 'pal',
        'timestamp': FieldValue.serverTimestamp()
      });
      messageController.clear();
    } catch (e) {}
    // if (textEditingController.text.trim().isNotEmpty) {
    //   ChatMessageModel newMessage = ChatMessageModel(
    //     comment: textEditingController.text.trim(),
    //   );

    //   setState(() {
    //     messageList.add(newMessage);
    //     textEditingController.text = '';
    //   });
    // }
  }

  Widget buildMessageTextField() {
    return Container(
      child: Container(
        padding: EdgeInsets.all(12),
        color: Colors.white,
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write text message...',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xffAEA4A3),
                  ),
                ),
                textInputAction: TextInputAction.send,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                onSubmitted: (_) {
                  addNewMessage();
                },
              ),
            ),
            Container(
              width: 50.0,
              child: InkWell(
                onTap: addNewMessage,
                child: Icon(
                  Icons.send,
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: messagesDoc
              .doc(auth!.uid)
              .collection('pals')
              .doc(widget.palid)
              .collection('thread')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            print('++++++++++++++++++++++++++++');
            print(widget.palid);
            // print(snapshot.data!.docs[0]['message']);
            print('++++++++++++++++++++++++++++');
            if (!snapshot.hasData) {
              Container(
                color: Colors.white60,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child:
                        // CircularProgressIndicator(),
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

              return Container(
                // child: Center(
                //   child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // child: Padding(
                    // padding: const EdgeInsets.all(12.0),
                    data.length < 1
                        ? Expanded(child: Container())
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ListView.builder(
                                  itemCount: data.length,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    print(data[index]['message']);
                                    return Bubble(
                                        child: Text(
                                          '${data[index]['message']}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        style: data[index]['sender'] == 'me'
                                            ? styleMe
                                            : data[index]['sender'] == 'pal'
                                                ? styleSomebody
                                                : styleMe);
                                  }),
                            ),
                          ),

                    buildMessageTextField()
                  ],
                ),
                //   ),
                // ),
              );
            }
            return Container(
              color: Colors.white60,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child:
                      // CircularProgressIndicator(),
                      FlareActor(
                    'assets/loading.flr',
                    animation: 'loading',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
