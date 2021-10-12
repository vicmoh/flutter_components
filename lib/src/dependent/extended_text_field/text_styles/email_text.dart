import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

/// Email special text.
class EmailText extends SpecialText {
  /// The input field text controller.
  final TextEditingController? controller;

  /// Start
  final int? start;

  /// The current build context.
  final BuildContext? context;

  /// The email text background color.
  final Color backgroundColor;

  /// Email special text.
  EmailText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback? onTap, {
    this.start,
    this.controller,
    this.context,
    required String startFlag,
    this.backgroundColor = Colors.transparent,
  }) : super(startFlag, " ", textStyle, onTap: onTap);

  @override
  bool isEnd(String value) {
    var index = value.indexOf("@");
    var index1 = value.indexOf(".");

    return index >= 0 &&
        index1 >= 0 &&
        index1 > index + 1 &&
        super.isEnd(value);
  }

  @override
  InlineSpan finishText() {
    final String text = toString();

    return ExtendedWidgetSpan(
        actualText: text,
        start: start!,
        alignment: ui.PlaceholderAlignment.middle,
        child: GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 5.0, top: 2.0, bottom: 2.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Container(
                        padding: EdgeInsets.all(5.0),
                        color: this.backgroundColor,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(text.trim()),
                              SizedBox(width: 5.0),
                              InkWell(
                                  child: Icon(Icons.close, size: 15.0),
                                  onTap: () {
                                    if (controller != null)
                                      controller?.value = controller!.value
                                          .copyWith(
                                              text: controller!
                                                  .text
                                                  .replaceRange(start!,
                                                      start! + text.length, ""),
                                              selection:
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset: start!)));
                                  }),
                            ])))),
            onTap: () {}),
        deleteAll: true);
  }
}
