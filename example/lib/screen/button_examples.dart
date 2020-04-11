import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class ButtonExamples extends StatefulWidget {
  ButtonExamples({Key key}) : super(key: key);

  @override
  _ButtonExamplesState createState() => _ButtonExamplesState();
}

class _ButtonExamplesState extends State<ButtonExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton.dropDown(
                  onChanged: (val) {}, buttonLabel: 'This is a dropdown')),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomButton.circle(
                  outlineColor: Theme.of(context).primaryColor,
                  outlineWeight: 3,
                  size: 50,
                  child: Text('20k'),
                  onPressed: () {})),
        ],
      ),
    );
  }
}
