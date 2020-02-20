import 'package:flutter/material.dart';

/// This class are consist of global functions used
/// for page transitions and animations.
class PageTransitions {
  /// Route page with fade transitions.
  static PageRouteBuilder fade(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.easeIn;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return FadeTransition(opacity: animation.drive(tween), child: child);
        });
  }
}
