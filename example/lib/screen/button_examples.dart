import 'package:example/screen/phone_field_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

class ButtonExamples extends StatefulWidget {
  ButtonExamples({super.key});

  @override
  _ButtonExamplesState createState() => _ButtonExamplesState();
}

class _ButtonExamplesState extends State<ButtonExamples> {
  _pageFadeTest() => PageTransitions.fade(PhoneFieldExample());

  _transBkgExample() => TransparentBackground.show(context,
      child: Center(
          child: Container(width: 100, height: 100, color: Colors.white)));

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
              padding: const EdgeInsets.all(8.0),
              child: CustomButton.withText(
                  onPressed: () => Navigator.push(context, _pageFadeTest()),
                  buttonLabel: 'Testing transition fade example')),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton.withText(
                  onPressed: () => _transBkgExample(),
                  buttonLabel: 'Testing trans background example.')),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomButton.circle(
                  outlineColor: Theme.of(context).primaryColor,
                  outlineWeight: 3,
                  size: 50,
                  child: Text('20k'),
                  onPressed: () {
                    print('20K is pressed.');
                  })),
        ],
      ),
    );
  }
}
