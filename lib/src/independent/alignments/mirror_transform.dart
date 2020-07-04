import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Transform any widget in mirror effect.
class MirrorTransform extends StatelessWidget {
  /// Transform any widget in mirror effect.
  const MirrorTransform({Key key, this.child})
      : assert(child != null, 'child must not be null.'),
        super(key: key);

  /// The widget to be transform
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: child,
    );
  }
}
