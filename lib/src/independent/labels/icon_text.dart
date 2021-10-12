import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Widget icon;
  final Widget text;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment alignment;
  final void Function()? onPressed;

  /// Simple flat text button with icon on the left.
  IconText({
    required this.icon,
    required this.text,
    this.alignment = MainAxisAlignment.start,
    this.padding = const EdgeInsets.all(0.0),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: this.onPressed,
        child: Container(
            padding: this.padding,
            child: Row(mainAxisAlignment: alignment, children: <Widget>[
              Container(child: icon),
              Container(child: text, padding: EdgeInsets.only(left: 5.0)),
            ])));
  }
}
