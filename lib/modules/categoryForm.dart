import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:takaconnect/modules/availability.dart';
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
  Map<String, dynamic> dropDownMap = {};
  TextEditingController size = TextEditingController();
  TextEditingController quality = TextEditingController();
  final CollectionReference wasteColl =
      FirebaseFirestore.instance.collection('waste');
  DateTime selectedEndDate = DateTime.now();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void showSnackbar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() {
      dropDownMap['Characteristics']['Color'] = pickerColor = color;
    });
  }

  // Color picker Dialog
  formColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //submit methods....
  collect() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (dropDownMap.containsKey('Waste Category') &&
        dropDownMap.containsKey('Material Type') &&
        dropDownMap.containsKey('Characteristics') &&
        dropDownMap.containsKey('Quality') &&
        dropDownMap.containsKey('Quantity')) {
      try {
        dropDownMap.containsKey('Date')
            ? dropDownMap['Date'] = dropDownMap['Date']
            : dropDownMap['Date'] = selectedEndDate;
        dropDownMap['user'] = firebaseUser!.uid;
        await wasteColl.add(dropDownMap).then((value) {
          showSnackbar('Waste added successfully!');
          quality.clear();
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
            wasteType: dropDownMap['Material Type']),
      ),
    );
  }

  buy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailabilityPage(
            wasteCategory: dropDownMap['Waste Category'],
            wasteType: dropDownMap['Material Type']),
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
      body: Container(
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
                                        dropDownMap['Date'] = DateTime.parse(v);
                                        selectedEndDate = DateTime.parse(v);
                                      });
                                      return v;
                                    },
                                    isDate: true,
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
                              print('########################################');
                              print(dropDownMap);
                              print('########################################');
                              return v;
                            },
                                isDropDown: true,
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

                            Column(children: <Widget>[
                              InkWell(
                                onTap: () => formColorPicker,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Color'),
                                    Expanded(
                                      child: Container(
                                        color: pickerColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InputCard('Size', (v) {
                                setState(() {
                                  dropDownMap['Characteristics']['Size'] = v;
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                  print(v);
                                  print(dropDownMap);
                                  print(quality.text);
                                  print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                                });
                                return v;
                              }, inputController: size),
                            ]),
                            // InputCard('Characteristics', (v) {
                            //   setState(() {
                            //     dropDownMap['Characteristics'] = v;
                            //     print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                            //     print(v);
                            //     print(dropDownMap);

                            //     print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
                            //   });
                            //   return v;
                            // }, isDropDown: true, passedList: ['Color', 'Size']),

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
                                inpuType: TextInputType.number,
                                inputController: quality),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(getColor)),
                          onPressed: () {
                            setState(() {
                              dropDownMap['Characteristics']['Color'] =
                                  pickerColor;
                            });
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
    );
  }
}
