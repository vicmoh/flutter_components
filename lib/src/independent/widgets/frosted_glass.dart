import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlass extends StatefulWidget {
  final double? blurHeight;
  final double? blurWidth;
  final double blurStrength;
  final Color blurColor;
  final BorderRadius borderRadius;
  final Widget? child;

  /// A widget that will blur a content.
  /// The [Child] is the widget you want to be blurred and
  /// The [Parent] is the widget on top of the blurred object.
  /// [blurColor] must be have transparency to be able
  /// to see the blur.
  FrostedGlass({
    Key? key,
    this.child,
    this.blurHeight,
    this.blurWidth,
    this.blurStrength = 10,
    this.blurColor = Colors.transparent,
    BorderRadius? borderRadius,
  })  : this.borderRadius = borderRadius ?? BorderRadius.circular(0),
        super(key: key);

  _FrostedGlassState createState() => _FrostedGlassState();
}

class _FrostedGlassState extends State<FrostedGlass> {
  double? _childHeight;
  double? _childWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _childHeight = constraints.maxHeight;
      _childWidth = constraints.maxWidth;

      return Container(
          height: widget.blurHeight,
          width: widget.blurWidth,
          decoration: BoxDecoration(borderRadius: widget.borderRadius),
          child: Stack(children: <Widget>[
            // The blur frosted glass effect
            Container(
                height: widget.blurHeight ?? _childHeight,
                width: widget.blurWidth ?? _childWidth,
                child: _blurEffect(context)),
            // The widgets on top of blurred effect
            (widget.child == null)
                ? Container()
                : Container(
                    height: widget.blurHeight ?? _childHeight,
                    width: widget.blurWidth ?? _childWidth,
                    child: widget.child),
          ]));
    });
  }

  // The blur effect
  Widget _blurEffect(BuildContext context) {
    return ClipRRect(
        borderRadius: widget.borderRadius,
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurStrength,
              sigmaY: widget.blurStrength,
            ),
            child: Container(
                height: widget.blurHeight ?? _childHeight,
                width: widget.blurWidth ?? _childWidth,
                child: Material(color: widget.blurColor))));
  }
}
