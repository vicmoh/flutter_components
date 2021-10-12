import 'package:flutter/material.dart';

class VerticalStretch extends StatelessWidget {
  final Widget? child;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// A class that stretches the [Widget]
  /// container vertically.
  const VerticalStretch({
    Key? key,
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: this.mainAxisAlignment,
            crossAxisAlignment: this.crossAxisAlignment,
            children: <Widget>[Expanded(child: this.child!)]));
  }
}
