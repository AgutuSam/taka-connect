import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:takaconnect/utils/alert.dart';
import 'package:takaconnect/utils/input.dart';
import 'package:takaconnect/utils/navbar1.dart';
import 'package:takaconnect/views/cardList.dart';
import 'package:intl/intl.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

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

  final CollectionReference wasteDoc =
      FirebaseFirestore.instance.collection('waste');

  static const TextStyle label = TextStyle(
    // h6 -> title
    // fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.18,
    color: Colors.orange,
    decoration: TextDecoration.underline,
  );

  String trash = 'All';
  late List<DataRow> dRow;
  getDataBody() {
    List<DataRow> _dRow = [];

    return StreamBuilder<QuerySnapshot>(
        stream: trash == 'All'
            ? wasteDoc
                .where('Date', isGreaterThanOrEqualTo: selectedStartDate)
                .where('Date', isLessThanOrEqualTo: selectedEndDate)
                .orderBy('Date')
                .snapshots()
            : wasteDoc
                .where('Waste Category', isEqualTo: trash)
                .where('Date', isGreaterThanOrEqualTo: selectedStartDate)
                .where('Date', isLessThanOrEqualTo: selectedEndDate)
                .orderBy('Date')
                .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return BeautifulAlertDialog('No such data yet');
          } else {
            List<DocumentSnapshot> data = snapshot.data!.docs;
            return data.isEmpty
                ? BeautifulAlertDialog('No data for this type yet')
                : Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Type')),
                            DataColumn(label: Text('Quantity (KG)')),
                          ],
                          rows:
                              List<DataRow>.generate(data.length, (int index) {
                            return DataRow(cells: [
                              DataCell(
                                Text(
                                    "${dateFormat.format(DateTime.parse(data[index]['Date'].toDate().toString()))}",
                                    textAlign: TextAlign.center),
                              ),
                              DataCell(
                                Container(
                                  width: 72,
                                  child: RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        text:
                                            "${data[index]['Material Type']}"),
                                  ),
                                ),
                              ),
                              DataCell(Text("${data[index]['Quantity']}",
                                  textAlign: TextAlign.center)),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  );
          }
        });
    // wasteDoc
    //     .where('Waste Category', arrayContainsAny: [trash, ''])
    //     .where('Date', isGreaterThanOrEqualTo: selectedStartDate)
    //     .where('Date', isLessThanOrEqualTo: selectedEndDate)
    //     .orderBy('Date')
    //     .get()
    //     .then((value) {
    //       var _tabList = value.docs.asMap().entries.map((widget) {
    //         print('KEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEY');
    //         print(widget.value.data());
    //         print('KEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEYKEY');
    //         return widget.key;
    //       }).toList();
    //       Map prods = value.docs.asMap();
    //       print('****************************');
    //       print(value);
    //       // print(_tabList);
    //       // print(_tabList.toString());
    //       // print(prods[_tabList[0]]['Material Type']);
    //       print('****************************');

    //       for (int i = 0; i < _tabList.length; i++) {
    //         _dRow.add(
    //           DataRow(cells: [
    //             DataCell(Text('${prods[_tabList[i]]['Date']}')),
    //             DataCell(Text('${prods[_tabList[i]]['Material Type']}')),
    //             DataCell(Text('${prods[_tabList[i]]['Quantity']}')),
    //           ]),
    //         );
    //       }
    //       setState(() {
    //         dRow = _dRow;
    //       });
    //     });

    // return _dRow;
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
              alignment: MediaQuery.of(context).viewInsets.bottom == 0
                  ? Alignment.center
                  : Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width > 1280
                    ? 414
                    : MediaQuery.of(context).size.width,
                child: SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? MediaQuery.of(context).size.height * 0.7
                      : MediaQuery.of(context).size.height * 0.9,
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, right: 4, left: 4),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Taka',
                            style: TextStyle(color: Colors.green, fontSize: 24),
                          ),
                          Divider(),
                          getDataBody(),
                          // rows: [
                          //   DataRow(cells: [
                          //     DataCell(Text('17/05/2021')),
                          //     DataCell(Text('Rubber')),
                          //     DataCell(Text('5')),
                          //   ]),
                          //   DataRow(cells: [
                          //     DataCell(Text('21/07/2021')),
                          //     DataCell(Text('Steel')),
                          //     DataCell(Text('58')),
                          //   ]),
                          //   DataRow(cells: [
                          //     DataCell(Text('11/06/2021')),
                          //     DataCell(Text('Glass')),
                          //     DataCell(Text('17')),
                          //   ]),
                          // ),
                          // SizedBox(height: 30.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: <Widget>[
                          //     Text(
                          //       "Total Collection",
                          //       style: label,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: <Widget>[
                          //     Text(
                          //       '900 KG',
                          //       style: TextStyle(
                          //           color: Colors.green[600], fontSize: 54),
                          //     ),
                          //     // Text(data['Waste Category']),
                          //     // Text(data['Material Type']),
                          //   ],
                          // ),
                          // SizedBox(height: 40.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: <Widget>[
                          //     Text(
                          //       "Total Sales",
                          //       style: label,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: <Widget>[
                          //     Text(
                          //       'Ksh 19,000',
                          //       style: TextStyle(
                          //           color: Colors.green[600], fontSize: 54),
                          //     ),
                          //     // Text(data['Waste Category']),
                          //     // Text(data['Material Type']),
                          //   ],
                          // ),
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
