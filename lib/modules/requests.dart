import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: wasteDoc.where('user', isEqualTo: auser!.uid).snapshots(),
            builder: (BuildContext context, snapshot) {
              List<DocumentSnapshot> data = snapshot.data!.docs;
              // var res =
              //     data.where((element) => element.id == widget.wasteId).first;
              List reqs = uzer['role'] == 'Collector'
                  ? data
                      .asMap()
                      .entries
                      .where((element) => element.value['user'] == auser!.uid)
                      .map((res) => res.value)
                      .toList()
                  : data
                      .asMap()
                      .entries
                      .where((element) =>
                          element.value['Request'].key == auser!.uid)
                      .map((res) => res.value)
                      .toList();
              return ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                var val = reqs[index];
                return Text(val['Material Type']);
              });
            }),
      ),
    );
  }
}
