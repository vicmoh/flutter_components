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
    SpecialTextGestureTapCallback onTap, {
    this.showAtBackground = false,
    @required this.start,
    @required this.flag,
  })  : assert(start != null, 'start must not be null.'),
        assert(flag != null, 'flag must not be null.'),
        super(flag, " ", textStyle, onTap: onTap);

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
