import 'package:flutter/material.dart';

/// This class are consist of global functions used
/// for page transitions and animations.
class PageTransitions {
  /// Route page with fade transitions.
  ///
  /// Example usage:
  /// ```dart
  /// Navigator.push(context, PageTransitions.fade(SomePage()));
  /// ```
  static PageRouteBuilder fade(Widget page,
      {Curve? curve, Duration? duration}) {
    return PageRouteBuilder(
        transitionDuration: duration ?? Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve ?? Curves.easeIn));
          return FadeTransition(opacity: animation.drive(tween), child: child);
        });
  }
}
