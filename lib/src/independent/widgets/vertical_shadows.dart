import 'package:flutter/material.dart';

class VerticalShadows extends StatelessWidget {
  final Widget child;
  final List<Color> shadows;

  /// The widget create inner shadows on top of the [child].
  /// Useful to darken an images. The widget uses [stack]
  /// where the shadows will be on top of the child.
  VerticalShadows({
    @required this.child,
    @required this.shadows,
  });

  /// Create the widget
  @override
  Widget build(BuildContext context) {
    var expanded = (child) => Column(children: [Expanded(child: child)]);
    return Container(
      child: Stack(children: <Widget>[
        // The background cover image
        expanded(this.child),
        // The image shadow
        expanded(IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: this.shadows)),
          ),
        )),
      ]),
    );
  }
}
