import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Clickable text types for the text that
/// are clickable. Used in [SmartText].
enum ClickableTextTypes { hyperlink, hashtag, atTag }

/// Smart text containing clickable hash tags
/// and hyper links.
class SmartText extends StatefulWidget {
  /// The text string.
  final String text;

  /// The default text style.
  final TextStyle style;

  /// The at symbol style.
  final TextStyle atTextStyle;

  /// The hash tag style.
  final TextStyle hashtagStyle;

  /// The hyper url link style.
  final TextStyle hyperlinkStyle;

  /// Text overflow type.
  final TextOverflow overflow;

  /// Number of lines the text will hold.
  final int maxLines;

  /// Text alignment.
  final TextAlign textAlign;

  /// Callback function when a clickable text is
  /// on pressed.
  final Function(String, ClickableTextTypes) onPressed;

  /// Smart text containing clickable hash tags
  /// and hyper links.
  SmartText(
    this.text, {
    Key key,
    this.onPressed,
    this.maxLines,
    this.style = const TextStyle(color: Colors.black),
    this.hashtagStyle,
    this.hyperlinkStyle,
    this.atTextStyle,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  static const HTTP_REGEX =
      r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";
  static const URL_REGEX =
      r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)";
  static const HASH_TAG_REGEX = r"(?:\s|^)#[A-Za-z0-9\-\.\_]+(?:\s|$)";
  static const AT_TAG_REGEX = r"(?:\s|^)@[A-Za-z0-9\-\.\_]+(?:\s|$)";

  @override
  _SmartTextState createState() => _SmartTextState();
}

class _SmartTextState extends State<SmartText> {
  List<TapGestureRecognizer> _tapGestures = [];

  @override
  void initState() {
    super.initState();
    this.widget.text?.split(' ')?.forEach((word) {
      word += ' ';
      if (RegExp(SmartText.HASH_TAG_REGEX).hasMatch(word))
        _tapGestures.add(TapGestureRecognizer());
      else if (RegExp(SmartText.URL_REGEX).hasMatch(word))
        _tapGestures.add(TapGestureRecognizer());
    });
  }

  @override
  void dispose() {
    _tapGestures?.forEach((gest) => gest?.dispose());
    super.dispose();
  }

  List<TextSpan> _texts(String text) {
    assert(text != null);
    List<TextSpan> textWidgets = [];
    int gestCount = 0;
    text?.split(' ')?.forEach((word) {
      word += ' ';
      if (widget.hashtagStyle != null &&
          RegExp(SmartText.HASH_TAG_REGEX).hasMatch(word)) {
        try {
          textWidgets.add(TextSpan(
              text: word,
              style: this.widget.hashtagStyle,
              recognizer: _tapGestures[gestCount++]
                ..onTap = () {
                  if (this.widget?.onPressed != null)
                    this.widget.onPressed(word, ClickableTextTypes.hashtag);
                }));
        } catch (err) {
          textWidgets.add(TextSpan(text: word, style: this.widget.style));
        }
      } else if (widget.hyperlinkStyle != null &&
          RegExp(SmartText.URL_REGEX).hasMatch(word)) {
        try {
          textWidgets.add(TextSpan(
              text: word,
              style: this.widget.hyperlinkStyle,
              recognizer: _tapGestures[gestCount++]
                ..onTap = () {
                  if (this.widget?.onPressed != null)
                    this.widget.onPressed(word, ClickableTextTypes.hyperlink);
                }));
        } catch (err) {
          textWidgets.add(TextSpan(text: word, style: this.widget.style));
        }
      } else if (widget.atTextStyle != null &&
          RegExp(SmartText.AT_TAG_REGEX).hasMatch(word)) {
        try {
          textWidgets.add(TextSpan(
              text: word,
              style: this.widget.atTextStyle,
              recognizer: _tapGestures[gestCount++]
                ..onTap = () {
                  if (this.widget?.onPressed != null)
                    this.widget.onPressed(word, ClickableTextTypes.atTag);
                }));
        } catch (err) {
          textWidgets.add(TextSpan(text: word, style: this.widget.style));
        }
      } else
        textWidgets.add(TextSpan(text: word, style: this.widget.style));
    });
    return textWidgets;
  }

  @override
  Widget build(BuildContext context) => RichText(
      textAlign: this.widget.textAlign,
      maxLines: this.widget.maxLines,
      overflow: this.widget.overflow,
      text: TextSpan(
          style: this.widget.style, children: _texts(this.widget.text)));
}
