import 'package:flutter/material.dart';

class HideKeyboardGesture extends StatefulWidget {
  final Widget child;

  /// Unfocus gesture. This class is mainly used
  /// for [IOS] keyboard to be close and hide.
  /// To hide the keyboard. Wrap the root of [Scaffold]
  /// page with this class.
  HideKeyboardGesture({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _HideKeyboardGestureState createState() => _HideKeyboardGestureState();
}

class _HideKeyboardGestureState extends State<HideKeyboardGesture> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: widget.child,
        onVerticalDragCancel: () =>
            FocusScope.of(context).requestFocus(_focusNode),
        onVerticalDragStart: (_) =>
            FocusScope.of(context).requestFocus(_focusNode));
  }
}
