import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

/// The text style symbol text, which
/// will start the text styled span.
class TextStyleStartSpan extends SpecialText {
  /// The at start recognizing of the symbol.
  final int start;

  /// Whether show background for #somebody
  final bool showAtBackground;

  /// The flag which will trigger the text style.
  final String flag;

  /// The at tag symbol text.
  TextStyleStartSpan(
    TextStyle textStyle,
    SpecialTextGestureTapCallback? onTap, {
    this.showAtBackground = false,
    required this.start,
    required this.flag,
  }) : super(flag, " ", textStyle, onTap: onTap);

  @override
  bool isEnd(String val) {
    var newLine = val.indexOf("\n");
    var newLine2 = val.indexOf("\r\n");
    var tab = val.indexOf('\t');
    var space = val.indexOf(' ');
    return (newLine > 0 || newLine2 > 0 || tab > 0 || space > 0);
  }

  @override
  InlineSpan finishText() {
    final String styledText = toString();
    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blueAccent,
            text: styledText,
            actualText: styledText,
            start: start,
            deleteAll: true,
            style: textStyle)
        : SpecialTextSpan(
            text: styledText,
            actualText: styledText,
            start: start,
            style: textStyle);
  }
}
