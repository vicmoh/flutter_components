import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import '../text_styles/text_style_start_span.dart';

/// Special text span builder for building special text.
class GenericInputSpanBuilder extends SpecialTextSpanBuilder {
  static const _HASH_FLAG = '#';
  static const _AT_FLAG = '@';
  static const _HTTPS_FLAG = 'https://';

  /// whether show background for @somebody
  final bool showAtBackground;

  /// Hash tag style.
  final TextStyle hashTextStyle;

  /// The at text style.
  final TextStyle atTextStyle;

  /// The https text style.
  final TextStyle httpsTextStyle;

  /// Special text span builder for building special text.
  GenericInputSpanBuilder({
    this.showAtBackground = false,
    this.hashTextStyle,
    this.atTextStyle,
    this.httpsTextStyle,
  });

  @override
  TextSpan build(
    String data, {
    TextStyle textStyle,
    onTap,
  }) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText createSpecialText(
    String flag, {
    TextStyle textStyle,
    SpecialTextGestureTapCallback onTap,
    int index,
  }) {
    if (flag == null ||
        flag.trim() == "" ||
        flag.trim() == "\n" ||
        flag.trim() == "\t" ||
        flag == "\r\n") return null;
    if (this.hashTextStyle != null && isStart(flag, _HASH_FLAG))
      return TextStyleStartSpan(this.hashTextStyle ?? textStyle, onTap,
          flag: _HASH_FLAG,
          start: index - (_HASH_FLAG.length - 1),
          showAtBackground: showAtBackground);
    if (this.atTextStyle != null && isStart(flag, _AT_FLAG))
      return TextStyleStartSpan(this.atTextStyle ?? textStyle, onTap,
          flag: _AT_FLAG,
          start: index - (_AT_FLAG.length - 1),
          showAtBackground: showAtBackground);
    if (this.httpsTextStyle != null && isStart(flag, _HTTPS_FLAG))
      return TextStyleStartSpan(this.httpsTextStyle ?? textStyle, onTap,
          flag: _HTTPS_FLAG,
          start: index - (_HTTPS_FLAG.length - 1),
          showAtBackground: showAtBackground);
    return null;
  }
}
