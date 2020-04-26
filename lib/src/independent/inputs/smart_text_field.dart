import 'package:flutter/material.dart';

class SmartTextField extends StatefulWidget {
  SmartTextField({Key key}) : super(key: key);

  @override
  _SmartTextFieldState createState() => _SmartTextFieldState();
}

class _SmartTextFieldState extends State<SmartTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(child: TextField(inputFormatters: []));
  }
}
