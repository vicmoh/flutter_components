import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_components.dart';

/// Transparent background widget mostly used
/// for the background of a custom dialog.
class TransparentBackground extends StatefulWidget {
  TransparentBackground({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.black54,
    this.onBackgroundTap,
  }) : super(key: key);

  final Widget child;
  final Function()? onBackgroundTap;
  final Color backgroundColor;

  /// Show on a new page route where it
  /// is wrap with transparent scaffold widget.
  static Future<void> show(
    context, {
    required Widget child,
    Function()? onBackgroundTap,
    Color backgroundColor = Colors.black54,
  }) async {
    await Navigator.push(
        context,
        TransparentPageRoute(
            builder: (_) => Scaffold(
                backgroundColor: Colors.transparent,
                body: TransparentBackground(
                    onBackgroundTap: onBackgroundTap,
                    backgroundColor: backgroundColor,
                    child: child))));
  }

  @override
  _TransparentBackgroundState createState() => _TransparentBackgroundState();
}

class _TransparentBackgroundState extends State<TransparentBackground> {
  GestureDetector _background(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (this.widget.onBackgroundTap != null)
            this.widget.onBackgroundTap!();
          else
            Navigator.pop(context);
        },
        child: Column(children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Expanded(child: Container(color: this.widget.backgroundColor)),
            ]),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[_background(context), this.widget.child]);
  }
}
