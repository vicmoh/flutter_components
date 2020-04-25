import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class SmartTextExample extends StatefulWidget {
  SmartTextExample({Key key}) : super(key: key);

  @override
  _SmartTextExampleState createState() => _SmartTextExampleState();
}

class _SmartTextExampleState extends State<SmartTextExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmartText('Hello world this is #tag and url google.com',
                  onPressed: (val, clickType) =>
                      print('val = $val, clickType = $clickType'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14 * 1.5,
                      fontWeight: FontWeight.bold))),
        ]));
  }
}
