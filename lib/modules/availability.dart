import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:takaconnect/utils/alert.dart';
import 'package:takaconnect/utils/wasteDialog.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage(
      {Key? key,
      this.wasteCategory,
      this.wasteType,
      this.wasteColor,
      this.wasteSize,
      this.wasteQuality,
      this.wasteQuantity})
      : super(key: key);
  final wasteCategory;
  final wasteType;
  final wasteColor;
  final wasteSize;
  final wasteQuality;
  final wasteQuantity;

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  final CollectionReference userDoc =
      FirebaseFirestore.instance.collection('users');
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
                .where('Material Type', isEqualTo: widget.wasteType)
                .where('Color', isEqualTo: widget.wasteColor)
                .where('Size', isEqualTo: widget.wasteSize)
                .where('Quantity', isEqualTo: widget.wasteQuantity)
                .where('Quality', isEqualTo: widget.wasteQuality)
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
                                            wasteId: data[index].id,
                                            user: data[index]['user']));
                                  },
                                  isThreeLine: true,
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => WasteDialog(
                                                wasteId: data[index].id,
                                                user: data[index]['user']));
                                      },
                                      icon: Icon(Icons.more)),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(data[index]
                                                ['Waste Category'] ==
                                            'Plastic'
                                        ? 'https://cdn.pixabay.com/photo/2016/02/07/14/00/plastic-bottle-1184735_960_720.jpg'
                                        : data[index]['Waste Category'] ==
                                                'Glass'
                                            ? 'https://cdn.pixabay.com/photo/2018/04/08/19/55/bottles-3302316__340.jpg'
                                            : data[index]['Waste Category'] ==
                                                    'Paper'
                                                ? 'https://cdn.pixabay.com/photo/2012/12/24/08/38/paper-72063__340.jpg'
                                                : data[index][
                                                            'Waste Category'] ==
                                                        'E_waste'
                                                    ? 'https://cdn.pixabay.com/photo/2013/03/25/06/58/board-96597__340.jpg'
                                                    : data[index][
                                                                'Waste Category'] ==
                                                            'Foam'
                                                        ? 'https://media.istockphoto.com/photos/foam-food-containers-are-waste-problems-picture-id1015437486?b=1&k=6&m=1015437486&s=170667a&w=0&h=9aM5GUemnySanTnjU58KYaLxaZ8i918XuxVkRDz2ypA='
                                                        : data[index][
                                                                    'Waste Category'] ==
                                                                'Organic'
                                                            ? 'https://cdn.pixabay.com/photo/2021/06/07/18/16/organic-waste-6318633__340.jpg'
                                                            : data[index][
                                                                        'Waste Category'] ==
                                                                    'Metal'
                                                                ? 'https://cdn.pixabay.com/photo/2016/10/04/18/24/garbage-1715067__340.jpg'
                                                                : 'https://images.pexels.com/photos/3850512/pexels-photo-3850512.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260'),
                                    backgroundColor: Colors.transparent,
                                    radius: 20.0,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${data[index]['Waste Category']}',
                                        // 'hhhhh',
                                        style: TextStyle(),
                                      ),
                                      Text(
                                        '${data[index]['Material Type']}',
                                        style: TextStyle(),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  subtitle: FutureBuilder(
                                      future: userDoc
                                          .doc(data[index]['user'])
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        var data = snapshot.data;
                                        return data != null
                                            ? Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Name:',
                                                    style: TextStyle(),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${data['name']}',
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Phone:',
                                                    style: TextStyle(),
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
