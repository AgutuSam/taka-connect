import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: WasteDialog(),
        ),
      ),
    );
  }
}

class WasteDialog extends StatefulWidget {
  @override
  _WasteDialogState createState() => _WasteDialogState();
}

class _WasteDialogState extends State<WasteDialog> {
  final quantity = TextEditingController();

  static const TextStyle label = TextStyle(
    // h6 -> title
    // fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    letterSpacing: 0.18,
    color: Colors.orange,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: MediaQuery.of(context).viewInsets.bottom == 0
          ? Alignment.center
          : Alignment.topCenter,
      child: SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom == 0
            ? MediaQuery.of(context).size.height * 0.8
            : MediaQuery.of(context).size.height * 0.9,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              const Text(
                'Taka',
                style: TextStyle(color: Colors.green),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Category",
                    style: label,
                  ),
                  Text("Type", style: label)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Metal'),
                  Text('Iron Sheets'),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Color",
                    style: label,
                  ),
                  Text("Size", style: label)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Icon(Icons.brightness_1_sharp, color: Colors.red),
                      SizedBox(width: 4),
                      Text('Red'),
                    ],
                  ),
                  const Text('12x32ft'),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Quality",
                        style: label,
                      ),
                      Text(
                        'Broken',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        "Quantity",
                        style: label,
                      ),
                      Text(
                        '518',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: const <Widget>[
                    Text(
                      'Name:',
                      style: label,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(),
                    ),
                  ]),
                  Row(children: const <Widget>[
                    Text(
                      'Phone:',
                      style: label,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '+2540192837465',
                      style: TextStyle(),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton.icon(
                      icon: const Icon(Icons.message_outlined),
                      onPressed: () {},
                      label: const Text(
                        'Message',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () async {},
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Requested',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green),
                            ),
                            Icon(Icons.ac_unit, color: Colors.green)
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: const <Widget>[
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Icon(Icons.favorite),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Favorite'),
                        ]),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
