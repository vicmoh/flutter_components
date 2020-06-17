import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';

import '../text_styles/email_text.dart';

/// Special email span builder.
class EmailSpanBuilder extends SpecialTextSpanBuilder {
  /// Text editing controller to control the
  /// text field.
  final TextEditingController controller;

  /// The build context.
  final BuildContext context;

  /// Special email span builder.
  EmailSpanBuilder(this.context, {@required this.controller})
      : assert(controller != null, 'controller must not be null.');

  @override
  SpecialText createSpecialText(String flag,
      {TextStyle textStyle, onTap, int index}) {
    if (flag == null || flag == "") return null;
    if (!flag.startsWith(" ") && !flag.startsWith("@")) {
      return EmailText(textStyle, onTap,
          start: index,
          context: context,
          controller: controller,
          startFlag: flag);
    }
    return null;
  }
}
