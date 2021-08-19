import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:takaconnect/utils/alert.dart';
import 'package:takaconnect/utils/input.dart';
import 'package:takaconnect/utils/navbar1.dart';
import 'package:takaconnect/views/cardList.dart';
import 'package:intl/intl.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key, this.role, this.person}) : super(key: key);

  final String? role;
  final String? person;

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  DateTime selectedStartDate =
      DateTime.now().subtract(const Duration(days: 30));
  late ValueChanged<DateTime> selectStartDate;
  DateTime selectedEndDate = DateTime.now();
  late ValueChanged<DateTime> selectEndDate;

  DateFormat dateFormat = DateFormat('d/M/y');

  var auth = FirebaseAuth.instance.currentUser;

  final CollectionReference userDoc =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference wasteDoc =
      FirebaseFirestore.instance.collection('waste');
  bool showSpinner = true;
  Map uzer = {};
  String trash = 'All';
  late List<DataRow> dRow;

  spinner() async {
    await Future.delayed(Duration(seconds: 3)).then((value) => setState(() {
          showSpinner = !showSpinner;
        }));
  }

  Future getUser() async {
    await userDoc.doc(auth!.uid).get().then((value) => setState(() {
          uzer = value.data() as Map<String, dynamic>;
          print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWe');
          print(uzer['role']);
          print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWe');
        }));
  }

  @override
  void initState() {
    getUser();
    spinner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 240, 35, 0.96),
      appBar: AppBar(
        title: Center(child: Text('My Data')),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: NavBar1(),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Card(child: start()),
                    Card(child: end()),
                  ],
                ),
                InputCard(
                  'Type of Trash',
                  (val) {
                    spinner();
                    setState(() {
                      trash = val.toString();
                    });
                    return val;
                  },
                  isDropDown: true,
                  passedList: Team.analysis,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0, right: 12, left: 12),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width > 1280
                    ? 414
                    : MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, right: 4, left: 4),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Taka',
                            style: TextStyle(color: Colors.green, fontSize: 24),
                          ),
                          Divider(),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: trash == 'All'
                                        ? uzer['role'] != 'Collectors'
                                            ? wasteDoc
                                                .where('Date',
                                                    isGreaterThanOrEqualTo:
                                                        selectedStartDate)
                                                .where('Date',
                                                    isLessThanOrEqualTo:
                                                        selectedEndDate.add(const Duration(
                                                            days: 1)))
                                                .orderBy('Date',
                                                    descending: true)
                                                .snapshots()
                                            : wasteDoc
                                                .where('user',
                                                    isEqualTo: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)
                                                .where('Date',
                                                    isGreaterThanOrEqualTo:
                                                        selectedStartDate)
                                                .where('Date',
                                                    isLessThanOrEqualTo:
                                                        selectedEndDate.add(
                                                            const Duration(
                                                                days: 1)))
                                                .orderBy('Date',
                                                    descending: true)
                                                .snapshots()
                                        : uzer['role'] != 'Collectors'
                                            ? wasteDoc
                                                .where('Waste Category',
                                                    isEqualTo: trash)
                                                .where('Date',
                                                    isGreaterThanOrEqualTo:
                                                        selectedStartDate)
                                                .where('Date', isLessThanOrEqualTo: selectedEndDate.add(const Duration(days: 1)))
                                                .orderBy('Date', descending: true)
                                                .snapshots()
                                            : wasteDoc.where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('Waste Category', isEqualTo: trash).where('Date', isGreaterThanOrEqualTo: selectedStartDate).where('Date', isLessThanOrEqualTo: selectedEndDate.add(const Duration(days: 1))).orderBy('Date', descending: true).snapshots(),
                                    builder: (BuildContext context, snapshot) {
                                      if (!snapshot.hasData) {
                                        // return CircularProgressIndicator();
                                        return showSpinner
                                            ? CircularProgressIndicator()
                                            : BeautifulAlertDialog(
                                                'No such data yet');
                                      } else {
                                        List<DocumentSnapshot> data =
                                            snapshot.data!.docs;
                                        List reqs = data
                                            .asMap()
                                            .entries
                                            .where((one) => one.value['Request']
                                                .containsKey(auth!.uid))
                                            .where((one) =>
                                                one.value['Request']
                                                    [auth!.uid] ==
                                                true)
                                            .map((res) => res.value)
                                            .toList();
                                        return data.isEmpty
                                            ? showSpinner
                                                ? CircularProgressIndicator()
                                                : BeautifulAlertDialog(
                                                    'No data for this type yet')
                                            : DataTable(
                                                columns: [
                                                  DataColumn(
                                                      label: Text('Date')),
                                                  DataColumn(
                                                      label: Text('Type')),
                                                  DataColumn(
                                                      label: Text(
                                                          'Quantity (KG)')),
                                                ],
                                                rows: List<DataRow>.generate(
                                                    uzer['role'] != 'Collectors'
                                                        ? reqs.length
                                                        : data.length,
                                                    (int index) {
                                                  var wasteID = uzer['role'] !=
                                                          'Collectors'
                                                      ? reqs[index]
                                                      : data.toList()[index].id;
                                                  var val = uzer['role'] !=
                                                          'Collectors'
                                                      ? reqs[index]!
                                                      : data[index];
                                                  List req = val!['Request']!
                                                      .entries
                                                      .where((v) =>
                                                          v!.value == true)
                                                      .map((res) {
                                                    return res!.key;
                                                  }).toList();
                                                  print(
                                                      'EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEDF');
                                                  print(uzer['role'] !=
                                                      'Collectors');
                                                  print(uzer['role']);
                                                  print(auth!.uid);
                                                  print(reqs.length);
                                                  print(data.length);
                                                  print(
                                                      'EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEDF');

                                                  return uzer['role'] !=
                                                          'Collectors'
                                                      ? req.isNotEmpty &&
                                                              req.contains(
                                                                  auth!.uid)
                                                          ? DataRow(cells: [
                                                              DataCell(Text(
                                                                  "${dateFormat.format(DateTime.parse(val['Date'].toDate().toString()))}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center)),
                                                              DataCell(
                                                                Container(
                                                                  width: 72,
                                                                  child:
                                                                      RichText(
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    strutStyle: StrutStyle(
                                                                        fontSize:
                                                                            12.0),
                                                                    text: TextSpan(
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black),
                                                                        text:
                                                                            "${val['Material Type']}"),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(Text(
                                                                  "${val['Quantity']}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center)),
                                                            ])
                                                          : DataRow(cells: [
                                                              DataCell(
                                                                  Container()),
                                                              DataCell(
                                                                  Container()),
                                                              DataCell(
                                                                  Container()),
                                                            ])
                                                      : DataRow(cells: [
                                                          DataCell(
                                                            Text(
                                                                "${dateFormat.format(DateTime.parse(data[index]['Date'].toDate().toString()))}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          DataCell(
                                                            Container(
                                                              width: 72,
                                                              child: RichText(
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                strutStyle:
                                                                    StrutStyle(
                                                                        fontSize:
                                                                            12.0),
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    text:
                                                                        "${data[index]['Material Type']}"),
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Text(
                                                              "${data[index]['Quantity']}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                        ]);
                                                }),
                                              );
                                      }
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget start() {
    return TextButton(
      child: Text(
          'Start: ${selectedStartDate.day} / ${selectedStartDate.month} / ${selectedStartDate.year}'),
      onPressed: () {
        spinner();
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
              containerHeight: 210.0,
            ),
            showTitleActions: true,
            minTime: DateTime(2000, 1, 1),
            maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
          //confirm start date
          setState(() {
            selectedStartDate = date;
          });
        }, currentTime: selectedStartDate, locale: LocaleType.en);
      },
    );
  }

  Widget end() {
    return TextButton(
      child: Text(
          'End: ${selectedEndDate.day} / ${selectedEndDate.month} / ${selectedEndDate.year}'),
      onPressed: () {
        spinner();
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
              containerHeight: 210.0,
            ),
            showTitleActions: true,
            minTime: DateTime(2000, 1, 1),
            maxTime: DateTime.now(), onConfirm: (date) {
          //confirm end date
          setState(() {
            selectedEndDate = date;
          });
        }, currentTime: selectedEndDate, locale: LocaleType.en);
      },
    );
  }
}
