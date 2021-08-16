import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takaconnect/modules/availability.dart';
import 'package:takaconnect/modules/categoryHome.dart';
import 'package:takaconnect/utils/input.dart';
import 'package:takaconnect/views/cardList.dart';
import "../extentions/string_extension.dart";

class CategoryForm extends StatefulWidget {
  CategoryForm({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late bool verifyLoading = false;
  Map<String, dynamic> dropDownMap = {};
  TextEditingController size = TextEditingController();
  TextEditingController quality = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final CollectionReference wasteColl =
      FirebaseFirestore.instance.collection('waste');
  DateTime selectedEndDate = DateTime.now();

  static const TextStyle label = TextStyle(
    // h6 -> title
    // fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    letterSpacing: 0.18,
    color: Color(0xFF2e7d32),
  );

  void showSnackbar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

  //submit methods....
  collect() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    setState(() {
      verifyLoading = !verifyLoading;
    });
    if (dropDownMap.containsKey('Waste Category') &&
        dropDownMap.containsKey('Material Type') &&
        dropDownMap.containsKey('Color') &&
        dropDownMap.containsKey('Size') &&
        dropDownMap.containsKey('Quality') &&
        dropDownMap.containsKey('Quantity') &&
        dropDownMap.containsKey('Amount')) {
      try {
        dropDownMap.containsKey('Date')
            ? dropDownMap['Date'] = dropDownMap['Date']
            : dropDownMap['Date'] = selectedEndDate;
        dropDownMap['user'] = firebaseUser!.uid;
        dropDownMap['Request'] = 'def';
        await wasteColl.add(dropDownMap).then((value) {
          showDialog(
              context: context,
              builder: (context) {
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
                      child: Dialog(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Category",
                                    style: label,
                                  ),
                                  Text("Type", style: label)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dropDownMap['Waste Category']),
                                  Text(dropDownMap['Material Type']),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Characteristics:",
                                        style: label,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.brightness_1_sharp,
                                                color: dropDownMap['Color'] ==
                                                        'Red'
                                                    ? Colors.red
                                                    : dropDownMap['Color'] ==
                                                            'Orange'
                                                        ? Colors.orange
                                                        : dropDownMap[
                                                                    'Color'] ==
                                                                'Yellow'
                                                            ? Colors.yellow
                                                            : dropDownMap[
                                                                        'Color'] ==
                                                                    'Green'
                                                                ? Colors.green
                                                                : dropDownMap[
                                                                            'Color'] ==
                                                                        'Blue'
                                                                    ? Colors
                                                                        .blue
                                                                    : dropDownMap['Color'] ==
                                                                            'Indigo'
                                                                        ? Colors
                                                                            .indigo
                                                                        : dropDownMap['Color'] ==
                                                                                'Violet'
                                                                            ? Color(0xFF8F00FF)
                                                                            : Colors.transparent),
                                            SizedBox(width: 2),
                                            Text(dropDownMap['Color']),
                                          ],
                                        ),
                                        Text(dropDownMap['Size']),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Quality",
                                        style: label,
                                      ),
                                      Text(
                                        dropDownMap["Quality"],
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text('Waste added successfully!'),
                                    SizedBox(height: 20.0),
                                    Text('Wish to add another?'),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        verifyLoading = !verifyLoading;
                                      });
                                      Navigator.pop(context);
                                    },
                                    label: Text('Add'),
                                  ),
                                  TextButton.icon(
                                    icon: Icon(Icons.cancel),
                                    label: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryHomePage()));
                                    },
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
          quality.clear();
          size.clear();
          amountController.clear();
        });
      } catch (e) {
        print('ERERERERERERRERERRERERRERERRERERRERERER');
        print(e);
        print('ERERERERERERRERERRERERRERERRERERRERERER');
      }
    } else {
      showSnackbar('All fields must be filled!');
    }
  }

  recycle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailabilityPage(
            wasteCategory: dropDownMap['Waste Category'],
            wasteType: dropDownMap['Material Type'],
            wasteColor: dropDownMap['Color'],
            wasteSize: dropDownMap['Size'],
            wasteQuality: dropDownMap['Quality'],
            wasteQuantity: dropDownMap['Quantity']),
      ),
    );
  }

  buy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailabilityPage(
            wasteCategory: dropDownMap['Waste Category'],
            wasteType: dropDownMap['Material Type'],
            wasteColor: dropDownMap['Color'],
            wasteSize: dropDownMap['Size'],
            wasteQuality: dropDownMap['Quality'],
            wasteQuantity: dropDownMap['Quantity']),
      ),
    );
  }

  // submit method
  _submitForm() {
    widget.category.capitalize() == 'Collectors'
        ? collect()
        : widget.category.capitalize() == 'Buyers'
            ? buy()
            : widget.category.capitalize() == 'Recyclers'
                ? recycle()
                // ignore: unnecessary_statements
                : null;
  }

  // get color
  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.orange;
    }
    return Colors.green[600];
  }

  @override
  Widget build(BuildContext context) {
    String titlecat = widget.category.capitalize();
    String title = titlecat == 'Collectors'
        ? 'Collectors: Choose Waste Category'.toUpperCase()
        : titlecat == 'Buyers'
            ? 'Buyers: Choose Waste To Buy'.toUpperCase()
            : titlecat == 'Recyclers'
                ? 'Recyclers: Choose Waste To Recycle'.toUpperCase()
                : titlecat;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 12)),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        Container(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      // height: 700,
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              titlecat == 'Collectors'
                                  ? InputCard(
                                      'Date: ${selectedEndDate.day} / ${selectedEndDate.month} / ${selectedEndDate.year}',
                                      (v) {
                                        setState(() {
                                          dropDownMap['Date'] =
                                              DateTime.parse(v);
                                          selectedEndDate = DateTime.parse(v);
                                        });
                                        return v;
                                      },
                                      isDate: true,
                                      isIcon: Icons.calendar_today_outlined,
                                    )
                                  : Container(),
                              InputCard('Waste Category', (v) {
                                print('!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                print(v);
                                print('!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                setState(() {
                                  dropDownMap['Waste Category'] = v;
                                  print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                                  print(v);
                                  print(dropDownMap);
                                  print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                                });
                                print(
                                    '########################################');
                                print(dropDownMap);
                                print(
                                    '########################################');
                                return v;
                              },
                                  isDropDown: true,
                                  isIcon: Icons.delete_forever,
                                  passedList: Waste.wasteList
                                      .asMap()
                                      .entries
                                      .map((e) => e.value.name)
                                      .toList()),

                              dropDownMap.containsKey('Waste Category')
                                  ? InputCard('Material Type', (v) {
                                      print('!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                      print(v);
                                      print('!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                      setState(() {
                                        dropDownMap['Material Type'] = v;
                                        print(
                                            '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                                        print(v);
                                        print(dropDownMap);
                                        print(
                                            '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                                      });
                                      print(
                                          '########################################');
                                      print(dropDownMap);
                                      print(
                                          '########################################');
                                      return v;
                                    },
                                      isDropDown: true,
                                      isIcon: Icons.merge_type,
                                      passedList: Waste.wasteList
                                          .asMap()
                                          .entries
                                          .where((element) =>
                                              element.value.name ==
                                              dropDownMap['Waste Category'])
                                          .map((e) => e.value.subs)
                                          .first)
                                  : Container(),
                              // // characteristics

                              // Size
                              InputCard('Size', (v) {
                                setState(() {
                                  dropDownMap['Size'] = v;
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                  print(v);
                                  print(dropDownMap);

                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                });
                                return v;
                              },
                                  isDropDown: true,
                                  isIcon: Icons.height,
                                  passedList: [
                                    '8x8.5ft',
                                    '12x15ft',
                                    '16x20ft',
                                    '20x24ft'
                                  ]),

                              // color
                              Card(
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 30),
                                elevation: 11,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton(
                                        iconEnabledColor: Color(0xFF0000E2),
                                        hint: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: Icon(
                                                Icons.money,
                                                color: Color(0xFF0000E2),
                                              ),
                                            ),
                                            Text('Color',
                                                style: TextStyle(
                                                    color: Color(0xFF0000E2))),
                                          ],
                                        ),
                                        items: [
                                          'Red',
                                          'Orange',
                                          'Yellow',
                                          'Green',
                                          'Blue',
                                          'Indigo',
                                          'Violet'
                                        ].asMap().entries.map((val) {
                                          return DropdownMenuItem(
                                              value: val.value,
                                              onTap: () {
                                                setState(() {
                                                  dropDownMap['Color'] =
                                                      val.value;
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(val.value),
                                                  Icon(Icons.brightness_1_sharp,
                                                      color: val.value == 'Red'
                                                          ? Colors.red
                                                          : val.value ==
                                                                  'Orange'
                                                              ? Colors.orange
                                                              : val.value ==
                                                                      'Yellow'
                                                                  ? Colors
                                                                      .yellow
                                                                  : val.value ==
                                                                          'Green'
                                                                      ? Colors
                                                                          .green
                                                                      : val.value ==
                                                                              'Blue'
                                                                          ? Colors
                                                                              .blue
                                                                          : val.value == 'Indigo'
                                                                              ? Colors.indigo
                                                                              : val.value == 'Violet'
                                                                                  ? Color(0xFF8F00FF)
                                                                                  : Colors.transparent),
                                                ],
                                              ));
                                        }).toList(),
                                        onChanged: (v) {
                                          setState(() {
                                            dropDownMap['Color'] = v;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // quality
                              InputCard('Quality', (v) {
                                setState(() {
                                  dropDownMap['Quality'] = v;
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                  print(v);
                                  print(dropDownMap);
                                  print(quality.text);
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                });
                                return v;
                              },
                                  isIcon: FontAwesomeIcons.recycle,
                                  isDropDown: true,
                                  passedList: ['Broken', 'Whole']),
                              // quantity (amount)

                              InputCard('Quantity (Amount in Kgs)', (v) {
                                setState(() {
                                  dropDownMap['Quantity'] = v;
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                  print(v);
                                  print(dropDownMap);
                                  print(quality.text);
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                });
                                return v;
                              },
                                  isIcon: FontAwesomeIcons.balanceScale,
                                  inpuType: TextInputType.number,
                                  inputController: quality),

                              widget.category.capitalize() == 'Collectors'
                                  ? InputCard(
                                      'Amount',
                                      (amt) {
                                        setState(() {
                                          dropDownMap['Amount'] = amt;
                                        });
                                        return amt;
                                      },
                                      isIcon: FontAwesomeIcons.moneyBill,
                                      inputController: amountController,
                                    )
                                  : widget.category.capitalize() == 'Buyers' ||
                                          widget.category.capitalize() ==
                                              'Recyclers'
                                      ? Container()
                                      : Container(),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(27.0),
                      child: Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        getColor)),
                            onPressed: () {
                              // setState(() {
                              //   dropDownMap['Characteristics']['Color'] =
                              //       pickerColor;
                              // });
                              _submitForm();
                            },
                            child: Text(
                              widget.category.capitalize() == 'Collectors'
                                  ? 'Submit'
                                  : widget.category.capitalize() == 'Buyers' ||
                                          widget.category.capitalize() ==
                                              'Recyclers'
                                      ? 'Check Availability'
                                      : 'Continue',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: verifyLoading,
          child: Container(
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
          ),
        ),
      ]),
    );
  }
}
