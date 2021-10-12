import 'package:flutter/widgets.dart';

/// A transparent page route, use similar
/// way of any other page route.
class TransparentPageRoute extends PageRoute<void> {
  TransparentPageRoute({
    required this.builder,
    RouteSettings? settings,
    this.duration = const Duration(milliseconds: 300),
  }) : super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => this.duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final result = builder(context);
    return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(animation),
        child: Semantics(
            scopesRoute: true, explicitChildNodes: true, child: result));
  }
}
