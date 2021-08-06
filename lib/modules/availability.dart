import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:takaconnect/utils/alert.dart';
import 'package:takaconnect/utils/wasteDialog.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({Key? key, this.wasteCategory, this.wasteType})
      : super(key: key);
  final wasteCategory;
  final wasteType;

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  final CollectionReference wasteDoc =
      FirebaseFirestore.instance.collection('waste');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: wasteDoc
                .where('Waste Category', isEqualTo: widget.wasteCategory)
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
                    ? BeautifulAlertDialog(
                        'No waste of such properties available as of yet!')
                    : Container(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List<Widget>.generate(data.length, (int index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => WasteDialog(
                                            wasteId: data[index].id));
                                  },
                                  isThreeLine: true,
                                  leading: CircleAvatar(
                                    child: Text(
                                      // 'T',
                                      '${data[index]['Waste Category'][0]}',
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
                                        '${data[index]['Waste Category']}',
                                        // 'hhhhh',
                                        style: TextStyle(),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Text(
                                        '${data[index]['Material Type']}',
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
      ),
    );
  }
}
