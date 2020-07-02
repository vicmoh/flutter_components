import 'package:flutter/material.dart';

/// Get animation context.
class AnimateContext {
  /// Determine if controller has been disposed.
  bool get isControllerDisposed => _isControllerDisposed;
  bool _isControllerDisposed = false;

  /// The anime context.
  final BuildContext context;

  /// Animation control.
  final AnimationController controller;

  /// Get animation context.
  AnimateContext({
    @required this.context,
    @required this.controller,
  })  : assert(context != null, 'buildContext must not be null.'),
        assert(controller != null, 'controller must not be null.');
}

/// Animation state.
class AnimateState {
  /// The animate control.
  final BuildContext context;

  /// Get animation.
  final Animation<double> animation;

  /// Animation state.
  AnimateState({
    @required this.context,
    @required this.animation,
  })  : assert(context != null, 'buildContext must not be null.'),
        assert(animation != null, 'animation must not be null.');
}

/// Animate a widget. If the [control] is null
/// it will animate at the beginning of a state which will
/// animate once. [Builder] is a callback that returns
/// the widget you want to animate, it pass arguments of the
/// [Animation] value from the starting [begin] to [end].
class Animate extends StatefulWidget {
  final double begin;
  final double end;
  final Duration duration;
  final Curve curve;
  final Function(AnimateContext) control;
  final Function(AnimateState) builder;
  final Widget child;
  final Function(AnimateState, Widget child) render;

  /// Animate a widget. If the [control] is null
  /// it will animate at the beginning of a state which will
  /// animate once. [Builder] is a callback that returns
  /// the widget you want to animate, it pass arguments of the
  /// [Animation] value from the starting [begin] to [end].
  /// If [control] is not null, controller is not disposed
  /// Hence it should dispose the controller once done.
  Animate({
    Key key,
    @required this.begin,
    @required this.end,
    @required this.builder,
    this.control,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeIn,
  })  : assert(begin != null, 'begin must not be null.'),
        assert(end != null, 'end must not be null.'),
        assert(builder != null, 'builder must not be null.'),
        this.render = null,
        this.child = null,
        super(key: key);

  /// Similar to default animate constructor
  /// except widget that is passed in [child],
  /// does not get re-rendered, only. Hence,
  /// it is useful when Translating objects etc.
  /// If [control] is not null, controller is not disposed
  /// Hence it should dispose the controller once done.
  Animate.withChild({
    Key key,
    @required this.begin,
    @required this.end,
    @required this.child,
    @required this.render,
    this.control,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeIn,
  })  : assert(begin != null, 'begin must not be null.'),
        assert(end != null, 'end must not be null.'),
        assert(child != null, 'child must not be null.'),
        assert(render != null, 'render must not be null.'),
        this.builder = null,
        super(key: key);

  _AnimateState createState() => _AnimateState();
}

class _AnimateState extends State<Animate> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationControl;
  AnimateContext _animateContext;
  AnimateState _animateState;

  @override
  void initState() {
    super.initState();

    /// Initialize animation
    _animationControl =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
        CurvedAnimation(parent: _animationControl, curve: widget.curve));
    _animateContext =
        AnimateContext(controller: _animationControl, context: context);
    _animateState = AnimateState(animation: _animation, context: context);

    /// Controlling animation
    if (widget.control == null) {
      _animationControl?.forward();
      _animationControl?.addStatusListener((status) {
        if (status == AnimationStatus.completed) _animationControl?.stop();
      });
    } else
      widget?.control(_animateContext);
  }

  @override
  void dispose() {
    _animateContext._isControllerDisposed = true;
    _animationControl?.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: widget.child,
        animation: _animation,
        builder: (context, child) {
          if (widget.render != null && widget.child != null)
            return widget.render(_animateState, child);
          return widget.builder(_animateState);
        });
  }
}
