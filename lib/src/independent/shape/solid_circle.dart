import 'package:flutter/material.dart';

class SolidCircle extends StatelessWidget {
  /// A solid color circle. Sometimes used in notifications
  /// to show that there is unread content.
  const SolidCircle({
    Key? key,
    this.color = Colors.grey,
    this.size = 15,
    this.borderRadius = 90,
  }) : super(key: key);

  final Color color;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.size,
        width: this.size,
        decoration: BoxDecoration(
            color: this.color,
            borderRadius:
                BorderRadius.all(Radius.circular(this.borderRadius))));
  }
}
