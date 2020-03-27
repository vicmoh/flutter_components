import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screen/phone_field_example.dart';
import 'package:flutter_components/flutter_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Widget examples',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _btn(text, screen) => RaisedButton(
      child: Text(text),
      onPressed: () =>
          Navigator.push(context, CupertinoPageRoute(builder: (_) => screen)));

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Widget")),
      body: Center(
        child: ListView(children: <Widget>[
          /// testing elevation for custom field
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomField.round(
                  elevation: 10,
                  prefixIcon: Icon(Icons.search, color: Colors.purple),
                  backgroundColor: Colors.white,
                  onChanged: (val) {})),

          /// button test for phone field example
          _btn('Phone field example', PhoneFieldExample()),
        ]),
      ));
}
