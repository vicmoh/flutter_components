import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

/// The at symbol text.
class AtText extends SpecialText {
  /// The at tag flag symbol.
  static const String FLAG = "@";

  /// The at start recognizing of the symbol.
  final int? start;

  /// Whether show background for #somebody
  final bool showAtBackground;

  /// The at tag symbol text.
  AtText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground = false, this.start})
      : super(FLAG, " ", textStyle, onTap: onTap);

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
    final String atText = toString();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blueAccent,
            text: atText,
            actualText: atText,
            start: start!,
            deleteAll: true,
            style: textStyle)
        : SpecialTextSpan(
            text: atText, actualText: atText, start: start!, style: textStyle);
  }
}
