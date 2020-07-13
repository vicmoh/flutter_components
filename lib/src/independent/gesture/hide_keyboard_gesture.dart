import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: widget.child,
        // FocusScope.of(context).unfocus() is replaced,
        onVerticalDragCancel: () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
        onVerticalDragStart: (_) => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }
}
