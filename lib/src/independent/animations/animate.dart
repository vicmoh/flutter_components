import 'package:flutter/material.dart';

/// Animate a widget. If the [controlAnimation] is null
/// it will animate at the beginning of a state which will
/// animate once. [Builder] is a callback that returns
/// the widget you want to animate, it pass arguments of the
/// [Animation] value from the starting [begin] to [end].
class Animate extends StatefulWidget {
  final double begin;
  final double end;
  final Duration duration;
  final Curve curve;
  final Function(AnimationController) controlAnimation;
  final Function(Animation<double>) builder;
  final Widget child;
  final Function(BuildContext, Widget, Animation<double>) builderWithChild;

  /// Animate a widget. If the [controlAnimation] is null
  /// it will animate at the beginning of a state which will
  /// animate once. [Builder] is a callback that returns
  /// the widget you want to animate, it pass arguments of the
  /// [Animation] value from the starting [begin] to [end].
  Animate({
    Key key,
    @required this.begin,
    @required this.end,
    this.child,
    this.builder,
    this.builderWithChild,
    this.controlAnimation,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeIn,
  })  : assert(!(builder == null && builderWithChild == null) ||
            !(builderWithChild != null && child == null)),
        super(key: key);

  _AnimateState createState() => _AnimateState();
}

class _AnimateState extends State<Animate> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationControl;

  @override
  void initState() {
    super.initState();

    /// Initialize animation
    _animationControl =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
        CurvedAnimation(parent: _animationControl, curve: widget.curve));

    /// Controlling animation
    if (widget.controlAnimation == null) {
      _animationControl?.forward();
      _animationControl?.addStatusListener((status) {
        if (status == AnimationStatus.completed) _animationControl?.stop();
      });
    } else
      widget?.controlAnimation(_animationControl);
  }

  @override
  void dispose() {
    _animationControl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: widget.child,
        animation: _animation,
        builder: (context, child) {
          if (widget.builderWithChild != null && widget.child != null)
            return widget.builderWithChild(context, child, _animation);
          return widget.builder(_animation);
        });
  }
}
