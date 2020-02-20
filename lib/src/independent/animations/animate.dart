import 'package:flutter/material.dart';

class Animate extends StatefulWidget {
  final double begin;
  final double end;
  final Duration duration;
  final Curve curve;
  final Function(AnimationController) controlAnimation;
  final Function(Animation<double>) builder;

  /// Animate a widget. If the [controlAnimation] is null
  /// it will animate at the beginning of a state which will
  /// animate once. [Builder] is a callback that returns
  /// the widget you want to animate, it pass arguments of the
  /// [Animation] value from the starting [begin] to [end].
  Animate({
    Key key,
    @required this.begin,
    @required this.end,
    @required this.builder,
    this.controlAnimation,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeIn,
  }) : super(key: key);

  _AnimateState createState() => _AnimateState();
}

class _AnimateState extends State<Animate> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationControl;

  @override
  void initState() {
    super.initState();
    // Initialize animation
    _animationControl =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
        CurvedAnimation(parent: _animationControl, curve: widget.curve));
    // Controlling animation
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
      animation: _animation,
      builder: (context, child) => widget.builder(_animation),
    );
  }
}
