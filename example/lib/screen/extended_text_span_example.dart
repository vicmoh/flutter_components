import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';
import 'package:extended_text_field/extended_text_field.dart';

class ExtendedTextSpanExample extends StatefulWidget {
  @override
  createState() => _ExtendedTextSpanExampleState();
}

class _ExtendedTextSpanExampleState extends State<ExtendedTextSpanExample> {
  TextEditingController _emailControl;

  @override
  void initState() {
    super.initState();
    _emailControl = TextEditingController();
  }

  @override
  void dispose() {
    _emailControl?.dispose();
    super.dispose();
  }

  _text(String val) => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(val,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          _text('hash, at, and http'),
          ExtendedTextField(
              maxLines: 5,
              specialTextSpanBuilder: GenericInputSpanBuilder(
                  hashTextStyle: TextStyle(color: Colors.blue),
                  atTextStyle: TextStyle(color: Colors.red),
                  httpsTextStyle: TextStyle(color: Colors.green))),
          _text('hash only'),
          ExtendedTextField(
              specialTextSpanBuilder: GenericInputSpanBuilder(
                  hashTextStyle: TextStyle(color: Colors.blue))),
          _text('email chip'),
          ExtendedTextField(
              controller: _emailControl,
              specialTextSpanBuilder:
                  EmailSpanBuilder(context, controller: _emailControl)),
        ]),
      ));
}
