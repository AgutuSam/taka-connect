import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage(this.categoryTitle);
  final String categoryTitle;

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<UploadPage> {
  Map dropDownMap = {};
  final _formKey = GlobalKey<FormState>();

  Widget _entryField(String title,
      {bool isPassword = false,
      var isIcon = Icons.brightness_1_sharp,
      TextEditingController? controller,
      bool isDisabled = false,
      bool isDate = false,
      bool isDropDown = false,
      TextInputType inpuType = TextInputType.text,
      List? dropList}) {
    return Card(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      elevation: 11,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: isDropDown
          ? Container(
              width: MediaQuery.of(context).size.width - 60,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    iconEnabledColor: Color(0xFF0000E2),
                    hint: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.money,
                            color: Color(0xFF0000E2),
                          ),
                        ),
                        Text(
                            dropDownMap[title] == null
                                ? title
                                : dropDownMap[title],
                            style: TextStyle(color: Color(0xFF0000E2))),
                      ],
                    ),
                    items: dropList?.map((var value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.black)));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        dropDownMap[title] = val;
                      });
                    },
                  ),
                ),
              ),
            )
          : TextFormField(
              keyboardType: inpuType,
              readOnly: isDate ? true : isDisabled,
              obscureText: isPassword,
              controller: controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return '$title cannot be empty!';
                }

                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    isIcon,
                    color: Color(0xFF0000E2),
                  ),
                  hintText: title,
                  hintStyle: TextStyle(color: Color(0xFF0000E2)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text(widget.categoryTitle)),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              width: width * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        height: height * 0.54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _entryField('Color', isDropDown: true, dropList: [
                              'red',
                              'green',
                              'yellow',
                              'blue',
                              'orange',
                              'pink',
                              'black',
                              'brown',
                              'grey'
                            ]),
                            _entryField('Size',
                                isDropDown: true, dropList: ['x', 'xx', 'xxl']),
                            _entryField('Quality', isDropDown: true, dropList: [
                              'best',
                              'good',
                              'median',
                              'aweful',
                              'worst'
                            ]),
                            _entryField('Quantity',
                                isDropDown: true,
                                dropList: [
                                  'little',
                                  'much',
                                  'extra',
                                  'excess'
                                ]),
                            _entryField('Available Offers',
                                isDropDown: true,
                                dropList: [
                                  'double',
                                  'quadre',
                                  'tens',
                                  'duplex'
                                ]),
                            _entryField('Date', isDate: true),
                            MaterialButton(
                              onPressed: () {},
                              child: Text('Upload'),
                              color: Colors.green.shade900,
                            )
                          ],
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
    );
  }
}
