import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

/// The at symbol text.
class UrlText extends SpecialText {
  /// The at flag symbol.
  static const String FLAG = "http";

  /// The at start recognizing of the symbol.
  final int? start;

  /// whether show background for @somebody
  final bool showAtBackground;

  /// The at symbol text.
  UrlText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback onTap, {
    this.showAtBackground = false,
    this.start,
    required String startFlag,
  }) : super(startFlag, " ", textStyle);

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
    TextStyle? textStyle =
        this.textStyle?.copyWith(color: Colors.blue, fontSize: 16.0);
    final String atText = toString();
    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start!,
            deleteAll: true,
            style: textStyle)
        : SpecialTextSpan(
            text: atText, actualText: atText, start: start!, style: textStyle);
  }
}
