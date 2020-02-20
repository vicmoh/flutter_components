import 'package:flutter/material.dart';

class ScrollDetector extends StatefulWidget {
  final Function() onScrollStart;
  final Function() onScrollEnd;
  final Widget child;

  /// A widget that detects whether the [ListView]
  /// is scrolling or not. [onScrollStart] is when
  /// scrolling happens, and [onScrollEnd] is when
  /// scrolling stops.
  ScrollDetector({
    Key key,
    this.onScrollStart,
    this.onScrollEnd,
    @required this.child,
  }) : super(key: key);
  _ScrollDetectorState createState() => _ScrollDetectorState();
}

class _ScrollDetectorState extends State<ScrollDetector> {
  /// When scrolling
  bool _scrollingStarted() {
    if (widget.onScrollStart != null) widget?.onScrollStart();
    return false;
  }

  /// When idle
  bool _scrollingEnded() {
    if (widget.onScrollEnd != null) widget?.onScrollEnd();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: NotificationListener<ScrollStartNotification>(
            onNotification: (_) => _scrollingStarted(),
            child: NotificationListener<ScrollEndNotification>(
                onNotification: (_) => _scrollingEnded(),
                child: widget.child)));
  }
}
