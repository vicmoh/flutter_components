import 'package:flutter/material.dart';

/// A class the stretches the [Widget] Horizontally.
class HorizontalStretch extends StatelessWidget {
  final Widget? child;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// A class that stretches the [Widget]
  /// container horizontally.
  const HorizontalStretch({
    Key? key,
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: this.mainAxisAlignment,
            crossAxisAlignment: this.crossAxisAlignment,
            children: <Widget>[Expanded(child: this.child!)]));
  }
}
