import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

const DEBUG = false;

class AnimateExample extends StatefulWidget {
  @override
  _AnimateExampleState createState() => _AnimateExampleState();
}

class _AnimateExampleState extends State<AnimateExample> {
  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Animate.withChild(
            begin: MediaQuery.of(context).size.width,
            end: 0,
            control: (control) {
              control.forward();
              control.addListener(() {
                if (control.isCompleted) {
                  control.dispose();
                  if (DEBUG) print('animate with child is disposed.');
                }
              });
            },
            child: _widget(),
            render: (_, child, animate) => Transform.translate(
                offset: Offset(animate.value, 0), child: child)),
        Animate(
            begin: MediaQuery.of(context).size.width,
            end: 0,
            control: (control) {
              control.forward();
              control.addListener(() {
                if (control.isCompleted) {
                  control.dispose();
                  if (DEBUG) print('animate is disposed.');
                }
              });
            },
            builder: (animate) => Transform.translate(
                offset: Offset(animate.value, 0), child: _widget())),
      ]));

  _widget() => Container(height: 50, width: 50, color: Colors.red);
}
